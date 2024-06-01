//
//  HRVDescriptionView.swift
//  STLess
//
//  Created by iOS신상우 on 5/27/24.
//

import SwiftUI

struct HRVDescriptionView: View {
    var body: some View {
        VStack {
            descriptionView()
            legendListView()
                .padding(.top, 20)
            bottomInfoView()
        }
        .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    func descriptionView() -> some View {
        VStack(alignment: .leading) {
            Text("심박변이(HRV)란?")
                .padding(.bottom, 15)
                .font(.pdBold16)
            Text("심박변이는 심장의 박동 간격의 미세한 시간차이를 나타내요.일반적으로 심박변이가 높다면 우리의 몸이 휴식, 회복, 건강 등 안정적인 상황일 확률이 높으며, 반대로 심박변이가 낮다면 스트레스나 압박감, 감정적 긴장 등에 있을 확률이 높아요!")
                .padding(.bottom, 12)
            Text("Apple Watch는 심박 센서가 캡처한 심장 박동간 측정치의 표준 편차를 사용하여 심박 변이를 계산해요. 심박 변이 측정 기능은 18세 이상의 사용자를 대상으로 그 유효성이 확인되었어요.")
                .padding(.bottom, 10)
            Text("Stless: 에서는 이러한 심박변이 값에 따라 스트레스 정도를 다음과 같이 시각화 해서 보여줘요")
        }
        .font(.pdRegular14)
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
        VStack {
            Text("심박변이(HRV)란?")
        }
    }
}

#Preview {
    HRVDescriptionView()
}
