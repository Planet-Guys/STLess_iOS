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
            HStack {
                Text("\(value)")
                    .font(.pdSemiBold24)
                    .foregroundStyle(Color.black).opacity(0.9)
                Text(unit)
                    .font(.pdMedium11)
                    .foregroundStyle(Color.black).opacity(0.5)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(14)
        .background { Color.main }
        .clipShape(.rect(cornerRadius: 8))
    }
}

#Preview {
    InfoBox(title: "타이틀", value: 12, unit: "ms")
}
