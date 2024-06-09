//
//  InfoBox.swift
//  STLess
//
//  Created by iOS신상우 on 5/12/24.
//

import SwiftUI

struct InfoBox: View {
    
    var title: String
    var value: Int
    var unit: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.pdMedium13)
                .foregroundStyle(Color.black).opacity(0.7)
            Text(value == 0 ? "-" : "\(value)")
                .font(.pdSemiBold24)
                .foregroundStyle(Color.black).opacity(0.9)
                .overlay(alignment: .bottomTrailing) {
                    Text(unit)
                        .font(.pdMedium11)
                        .fixedSize()
                        .foregroundStyle(Color.black).opacity(0.5)
                        .offset(x: 20, y: -3)
                }
                .padding(.top, 1)
            
        }
        .frame(maxWidth: .infinity)
        .padding(14)
        .background { Color.main }
        .clipShape(.rect(cornerRadius: 8))
    }
}

#Preview {
    InfoBox(title: "타이틀", value: 0, unit: "ms")
}
