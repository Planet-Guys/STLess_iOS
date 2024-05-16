//
//  BarChart.swift
//  STLess
//
//  Created by iOS신상우 on 5/15/24.
//

import SwiftUI
import Charts

struct BarChart: View {
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
    
    var body: some View {
        Chart(items) { item in
            BarMark(
                x: .value("hour", item.hour),
                y: .value("hrv", item.hrv),
                width: .fixed(24),
                height: .automatic,
                stacking: .unstacked
            )
            .cornerRadius(6, style: .circular)
            .annotation(position: .top) {
                Text("\(item.hrv)")
                    .font(.caption)
                    .foregroundColor(.black)
            }
        }
        .frame(height: 196)
        .chartYScale(domain: 0...150)
        .chartYAxis {
            AxisMarks(position: .leading) { _ in
                AxisGridLine().foregroundStyle(.main)
                AxisValueLabel(horizontalSpacing: .zero,
                               verticalSpacing: .zero)
            }
        }
        .chartXAxis {
            AxisMarks(position: .bottom) { _ in
                AxisValueLabel(horizontalSpacing: .zero,
                               verticalSpacing: .zero)
            }
        }
        .if(items.count > 12, content: {
            $0.chartScrollableAxes(.horizontal)
        })
    }
}
