//
//  HRVDescriptionView.swift
//  STLess
//
//  Created by iOS신상우 on 5/27/24.
//

import SwiftUI
import ComposableArchitecture

struct HRVDescriptionView: View {
    var store: StoreOf<HRVDescriptionFeature>
    
    var body: some View {
        WithDesignSystem {
            TopNavigationBar(leadingItem: (Image.images(.back),
                                           nil, {
                store.send(.delegate(.back))
            }))
        } content: {
            ScrollView {
                descriptionView()
                    .padding(.top, 30)
                legendListView()
                    .padding(.top, 20)
                bottomInfoView()
                    .padding(.top, 100)
            }
            .padding(.horizontal, 20)
            .background(Color.white)
        }
    }
    
    @ViewBuilder
    func descriptionView() -> some View {
        VStack(alignment: .leading) {
            Text("심박변이(HRV)란?")
                .padding(.bottom, 15)
                .font(.pdBold16)
                .foregroundStyle(Color.black.opacity(0.95))
            Text("심박변이는 심장의 박동 간격의 미세한 시간차이를 나타내요.일반적으로 심박변이가 높다면 우리의 몸이 휴식, 회복, 건강 등 안정적인 상황일 확률이 높으며, 반대로 심박변이가 낮다면 스트레스나 압박감, 감정적 긴장 등에 있을 확률이 높아요!")
                .padding(.bottom, 12)
            Text("Apple Watch는 심박 센서가 캡처한 심장 박동간 측정치의 표준 편차를 사용하여 심박 변이를 계산해요. 심박 변이 측정 기능은 18세 이상의 사용자를 대상으로 그 유효성이 확인되었어요.")
                .padding(.bottom, 10)
            Text("Stless: 에서는 이러한 심박변이 값에 따라 스트레스 정도를 다음과 같이 시각화 해서 보여줘요")
        }
        .font(.pdRegular14)
        .foregroundStyle(Color.black.opacity(0.8))
    }
    
    @ViewBuilder
    func legendView(level: StressLevel) -> some View {
        let lower = level.range.lowerBound - 1
        let upper = level.range.upperBound
            HStack {
                if lower == 0 {
                    Text("• 심박변이 <= \(upper) :")
                } else {
                    Text("• \(lower) < 심박변이 <= \(upper) :")
                }
                
                level.icon
                    .resizable()
                    .frame(width: 40, height: 40)
                
                Text(level.comment)
                Spacer()
            }
            .font(.pdRegular14)
            .foregroundStyle(Color.black.opacity(0.8))
            
    }
    
    @ViewBuilder
    func legendListView() -> some View {
        VStack(alignment: .leading) {
            legendView(level: .bad)
            legendView(level: .caution)
            legendView(level: .normal)
            legendView(level: .good)
        }
    }
    
    @ViewBuilder
    func bottomInfoView() -> some View {
        VStack(spacing: 7) {
            Image.images(.info)
            Text("이 앱은 의료 목적으로 설계된 것이 아니며, 전문 의료진의 진단이나 치료를 대체할 수 없습니다. 건강 관리를 위해서는 반드시 의사나 전문가의 조언을 구하시기 바랍니다.")
                .font(.pretendard(size: 13, style: .regular))
                .foregroundStyle(Color.black.opacity(0.7))
                .multilineTextAlignment(.center)
        }
        .padding(15)
        .background(Color.main)
        .clipShape(.rect(cornerRadius: 8))
    }
}

#Preview {
    HRVDescriptionView(store: Store(initialState: HRVDescriptionFeature.State.main, reducer: {
        HRVDescriptionFeature()
    }))
}
