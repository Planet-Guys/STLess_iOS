//
//  MainView.swift
//  STLess
//
//  Created by iOS신상우 on 5/12/24.
//

import SwiftUI
import ComposableArchitecture

struct MainView: View {
    
    var body: some View {
        ScrollView {
            headerView()
            infoView()
            DividerView(thickness: 10,
                        padding: .zero)
            .padding(.top, 20)
            .padding(.bottom, 30)
            hrvView()
        }
    }
    
    @ViewBuilder
    func headerView() -> some View {
        Color.gray
            .frame(width: 193, height: 193)
            .padding(.top, 80)
            .padding(.bottom, 22)
        
        Text("스트레스가 전혀 없으신 것 같아요!")
            .font(.pdBold16)
            .foregroundStyle(Color.black).opacity(0.95)
            
        Text("오늘 하루, 세상에서 가장\n행복한 사람은 바로 당신일거예요.")
            .font(.pdRegular14)
            .foregroundStyle(Color.black).opacity(0.8)
            .padding(.top, 9)
            .multilineTextAlignment(.center)
    }
    
    @ViewBuilder
    func infoView() -> some View {
        VStack {
            HStack {
                Spacer()
                Text("2024.04.24 19:10")
                    .font(.pdRegular11)
                    .foregroundStyle(Color.black).opacity(0.5)
            }
            HStack(spacing: 10) {
                InfoBox(title: "가장 최근 심박변이",
                        value: 68,
                        unit: "ms")
                InfoBox(title: "오늘 평균 심박변이",
                        value: 39,
                        unit: "ms")
            }
            
            HStack {
                Spacer()
                Text("잠깐 심박변이가 뭐에요?")
                    .font(.pdMedium12)
                    .foregroundStyle(Color.black).opacity(0.7)
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
            HStack {
                Text("심박변이 추이")
                    .font(.pdSemiBold18)
                    .foregroundStyle(Color.black)
                Spacer()
                Color.gray
                    .frame(width: 20, height: 20)
            }
            
            Color.gray
                .frame(height: 47)
            
            Color.gray
                .frame(height: 196)
                .padding(.top, 40)
                .padding(.bottom, 20)
        }
        .padding(.horizontal, 20)
    }
}


#Preview {
    MainView()
}
