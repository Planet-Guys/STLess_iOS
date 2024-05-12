//
//  DividerView.swift
//  STLess
//
//  Created by iOS신상우 on 5/12/24.
//

import SwiftUI

struct DividerView: View {
    let color: Color
    let thickness: CGFloat
    let padding: CGFloat
    let direction: Direction
    
    init(
        color: Color = .main,
        thickness: CGFloat = 1,
        padding: CGFloat = 8,
        direction: Direction = .horizontal
    ) {
        self.color = color
        self.thickness = thickness
        self.padding = padding
        self.direction = direction
    }
    
    var body: some View {
        Rectangle()
            .frame(height: direction == .horizontal ? thickness : .none)
            .frame(width: direction == .vertical ? thickness : .none)
            .foregroundStyle(color)
            .padding(direction == .horizontal ? .vertical : .horizontal, padding)
            .frame(maxWidth: direction == .vertical ? .none : .infinity)
            .frame(maxHeight: direction == .horizontal ? .none : .infinity)
    }
}

enum Direction {
    case horizontal, vertical
}
