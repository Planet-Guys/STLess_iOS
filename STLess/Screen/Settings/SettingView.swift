//
//  SettingView.swift
//  STLess
//
//  Created by iOS신상우 on 6/2/24.
//

import SwiftUI
import ComposableArchitecture

struct SettingView: View {
    var store: StoreOf<SettingFeature>
    
    var body: some View {
        WithDesignSystem {
            TopNavigationBar(leadingItem: (Image.images(.back),
                                           nil, {
                store.send(.delegate(.back))
            }))
        } content: {
            ScrollView {
                VStack(alignment: .leading) {
                    titleView()
                    alramSetting()
                        .padding(.top, 15)
                    settingList()
                        .padding(.top, 30)
                }
                .padding(.top, 15)
                .padding(.horizontal, 20)
            }
            .background(Color.white)
        }
    }
    
    @ViewBuilder
    func titleView() -> some View {
        VStack(alignment: .leading) {
            Text("알림설정")
                .font(.pdSemiBold16)
                .foregroundStyle(Color.black.opacity(0.95))
            Text("스트레스 정도별로 알림 설정을 할 수 있어요.")
                .font(.pdMedium13)
                .foregroundStyle(Color.black.opacity(0.7))
                .padding(.top, 5)
        }
    }
    
    @ViewBuilder
    func alramSetting() -> some View {
        VStack(spacing: 5) {
            toggleView(dust: .bad, isOn: true)
            toggleView(dust: .caution, isOn: false)
            toggleView(dust: .normal, isOn: false)
            toggleView(dust: .good, isOn: false)
        }
    }
    
    @ViewBuilder
    func toggleView(dust: StressLevel, isOn: Bool) -> some View {
        HStack {
            dust.icon
                .resizable()
                .frame(width: 40, height: 40)
            dust.comment
            Toggle(isOn: .constant(isOn), label: { })
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 12)
        .background(Color.main)
        .clipShape(.rect(cornerRadius: 8))
        .foregroundStyle(Color.black)
    }
    
    @ViewBuilder
    func settingList() -> some View {
        VStack {
            settingItem(title: "이용약관", action: {
                // TODO: 이용약관
            })
            settingItem(title: "로그아웃", action: {
                // TODO: 로그아웃
            })
            settingItem(title: "회원탈퇴", action: {
                // TODO: 회원탈퇴
            })
        }
    }
    
    @ViewBuilder
    func settingItem(title: String, action: (()->Void)?) -> some View {
        Button {
            action?()
        } label: {
            HStack {
                Text(title)
                Spacer()
                Image.images(.disclosure)
                
            }
        }
        .font(.pdSemiBold16)
        .foregroundStyle(Color.black)
        .padding(.vertical, 10)
    }
}

#Preview {
    SettingView(store: Store(initialState: SettingFeature.State.main, reducer: {
        SettingFeature()
    }))
}
