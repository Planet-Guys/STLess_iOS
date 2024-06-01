//
//  OverlayToolTip.swift
//  UniwaffleDesignSystemPractice
//
//  Created by 현수빈 on 4/16/24.
//

import SwiftUI

private struct CustomTriangleShape: Shape {
    private var width: CGFloat
    private var height: CGFloat
    private var radius: CGFloat
    
    fileprivate init(
        width: CGFloat = 10,
        height: CGFloat = 9,
        radius: CGFloat = 1
    ) {
        self.width = width
        self.height = height
        self.radius = radius
    }
    
    fileprivate func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX + width / 2 - radius, y: rect.minY))
        path.addQuadCurve(
            to: CGPoint(x: rect.minX + width / 2 + radius, y: rect.minY),
            control: CGPoint(x: rect.minX + width / 2, y: rect.minY - radius)
        )
        path.addLine(to: CGPoint(x: rect.minX + width, y: rect.minY + height))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + height))
        path.closeSubpath()
        
        return path
    }
}

private struct CustomRectangleShape: View {
    private var text: String
    
    fileprivate init(text: String) {
        self.text = text
    }
    
    fileprivate var body: some View {
        Text(text)
            .font(.pdRegular12)
            .foregroundColor(.white.opacity(0.9))
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.black.opacity(0.8))
            )
    }
}

public struct OverlayToolTip: View {
    
    private let text: String
    private let location: Alignment
    
    public init(
        text: String,
        location: Alignment = .leading
    ) {
        self.text = text
        self.location = location
    }
    
    public var body: some View {
        GeometryReader { geometry in
            CustomRectangleShape(text: text)
                .frame(width: geometry.size.width, height: 46)
                .overlay {
                    var  offset: CGFloat {
                        switch location {
                        case .leading:
                            return -0.3
                        case .center:
                            return 0
                        default:
                            return 0.3
                        }
                    }
                    CustomTriangleShape()
                        .fill(Color.black.opacity(0.8))
                        .frame(width: 10, height: 9)
                        .offset(x: geometry.size.width * offset, y: -24)
                }
        }
    }
}
