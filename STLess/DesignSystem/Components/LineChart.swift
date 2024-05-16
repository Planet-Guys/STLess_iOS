//
//  LineChart.swift
//  STLess
//
//  Created by iOS신상우 on 5/15/24.
//

import SwiftUI
import Charts

struct LineChart: View {
    let items: [HrvData] = [
        HrvData(hour: "00", hrv: 20),
        HrvData(hour: "03", hrv: 40),
        HrvData(hour: "06", hrv: 60),
        HrvData(hour: "09", hrv: 120),
        HrvData(hour: "12", hrv: 43),
        HrvData(hour: "15", hrv: 50),
        HrvData(hour: "18", hrv: 44),
        HrvData(hour: "21", hrv: 60),
        HrvData(hour: "24", hrv: 80),
    ]
    
    @State private var selectedX = 1
    
    var body: some View {
        Chart(items) { item in
            LineMark(x: .value("hour", item.hour),
                     y: .value("hrv", item.hrv))
            .symbol() {
                Circle()
                    .fill()
                    .frame(width: 6)                
            }
        }
        .frame(height: 196)
        .chartXAxis {
            AxisMarks(position: .bottom) { _ in
                AxisValueLabel(horizontalSpacing: .zero,
                               verticalSpacing: .zero)
            }
        }
        .if(items.count > 12, content: {
            $0.chartScrollableAxes(.horizontal)
        })
        .chartOverlay { proxy in
//            let pos1 = proxy.position(for: (x: selectedX, y: items[selectedX].hour)) ?? .zero
//            let pos2 = proxy.position(for: (x: selectedX+1, y: items[selectedX+1].hour)) ?? .zero
//            let lineHeight = (pos1.y + pos2.y) / 2.0 - 24
//            
//            VStack(spacing: 0) {
//                Text("x: \(selectedX), y: \(items[selectedX].hour)")
//                    .padding()
//                    .background(.gray.opacity(0.5))
//                Color.gray
//                    .frame(width: 1, height: lineHeight)
//            }
//            .position(x: (pos1.x + pos2.x)/2, y: lineHeight / 2 )
        }
        .padding()
    }
}

#Preview {
    LineChart()
}
