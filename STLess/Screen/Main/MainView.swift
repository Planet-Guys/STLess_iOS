//
//  MainView.swift
//  STLess
//
//  Created by iOS신상우 on 5/12/24.
//

import SwiftUI
import ComposableArchitecture
import Charts

struct MainView: View {
    var store: StoreOf<MainFeature>
    @ObservedObject var viewStore: ViewStoreOf<MainFeature>
    
    init(store: StoreOf<MainFeature>) {
        self.store = store
        self.viewStore = ViewStore(self.store, observe: { $0 })
    }
    
    var body: some View {
        NavigationStackStore(store.scope(state: \.path,
                                         action: \.path)) {
            ScrollView {
                VStack {
                    topView()
                    headerView()
                    infoView()
                    DividerView(thickness: 10,
                                padding: .zero)
                    .padding(.top, 20)
                    .padding(.bottom, 30)
                    hrvView()
                }
            }
            .background(Color.white)
            .onAppear(perform: {
                store.send(._onAppear)
            })
        } destination: { store in
            switch store.state {
            case .setting(.main):
                if let store = store.scope(state: \.setting, action: \.setting) {
                    SettingView(store: store)
                }
            case .stressInfo:
                if let _ = store.scope(state: \.stressInfo, action: \.stressInfo) {
                    HRVDescriptionView()
                }
            }
        }
    }
    
    @ViewBuilder
    func topView() -> some View {
        HStack {
            Image.images(.logo)
                .resizable()
                .frame(width: 72, height: 26)
            Spacer()
            
            NavigationLink(state: MainFeature.MainNaviagtionPath.State.setting(.main)) {
                Image.images(.setting)
            }
        }
        .frame(height: 44)
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    func headerView() -> some View {
        store.stressLevel.icon
            .frame(width: 193, height: 193)
            .padding(.top, 80)
            .padding(.bottom, 22)
        
        Text(store.stressLevel.title)
            .font(.pdBold16)
            .foregroundStyle(Color.black).opacity(0.95)
        
        Text(store.stressLevel.message)
            .font(.pdRegular14)
            .foregroundStyle(Color.black).opacity(0.8)
            .padding(.top, 9)
            .multilineTextAlignment(.center)
        
        if store.stressLevel == .none {
            Button {
                // TODO: 건강앱 권한 셋팅
            } label: {
                Text("허용하러 가기")
                    .font(.pretendard(size: 14, style: .bold))
                    .foregroundStyle(Color.white)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 28)
                    .background(Color.black)
                    .clipShape(.capsule)
            }
            .padding(.top, 16)
        }
    }
    
    @ViewBuilder
    func infoView() -> some View {
        VStack {
            HStack {
                Spacer()
                Text(store.recentlyInfoDate.formattedString(by: .yyyyMMddHHmm))
                    .font(.pdRegular11)
                    .foregroundStyle(Color.black).opacity(0.5)
            }
            HStack(spacing: 10) {
                InfoBox(title: "가장 최근 심박변이",
                        value: Int(store.recentlyHRV),
                        unit: "ms")
                
                InfoBox(title: "오늘 평균 심박변이",
                        value: Int(store.averageHRV),
                        unit: "ms")
            }
            
            HStack {
                Spacer()
                NavigationLink(state: MainFeature.MainNaviagtionPath.State.stressInfo) {
                    Text("잠깐! 심박변이가 뭐에요?")
                        .font(.pdMedium12)
                        .foregroundStyle(Color.black).opacity(0.7)
                        .underline(color: Color.black.opacity(0.7))
                }
                Button {
                    // TODO: Push
                } label: {
                    
                }
            }
            .padding(.top, 9)
            .underline()
        }
        .padding(.horizontal, 20)
        .padding(.top, 40)
    }
    
    @ViewBuilder
    func hrvView() -> some View {
        VStack {
            HStack(spacing: 2) {
                Text("심박변이 추이")
                    .font(.pdSemiBold18)
                    .foregroundStyle(Color.black)
                Image.images(.questionMark)
                    .resizable()
                    .frame(width: 20, height: 20)
                Spacer()
            }
            
            Picker("date", selection: viewStore.binding(
                get: { $0.dateType },
                send: { return .setDateType(type: $0) })) {
                    ForEach(DateType.allCases, id: \.self) {
                        Text($0.name)
                    }
                }
                .background { Color.main }
                .pickerStyle(.segmented)
                .frame(height: 47)
                .padding(.top, 25)
            
            switch store.dateType {
            case .daily:
                BarChart(items: store.dailyInfos)
            case .weekly:
                LineChart(items: store.dailyInfos)
                    .padding(.top, 40)
            case .monthly:
                Color.red
                    .frame(width: 300, height: 196)
                    .padding()
            }
        }
        .padding(.horizontal, 20)
    }
}


#Preview {
    MainView(store: Store(initialState: MainFeature.State()) {
        MainFeature()
    })
}
