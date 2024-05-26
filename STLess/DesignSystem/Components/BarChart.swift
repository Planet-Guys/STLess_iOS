//
//  BarChart.swift
//  STLess
//
//  Created by iOS신상우 on 5/15/24.
//

import SwiftUI
import Charts

struct BarChart: View {
    let items: [DailySDNNInfo]
    
    var body: some View {
        Chart(items) { item in
            BarMark(
                x: .value("hour", item.date.formatted(.dateTime.hour())),
                y: .value("hrv", item.sdnn),
                width: .fixed(20),
                height: .automatic,
                stacking: .unstacked
            )
            .cornerRadius(2, style: .circular)
            .annotation(position: .top) {
                Text("\(item.sdnn)")
                    .font(.caption)
                    .foregroundColor(.black)
            }
            .foregroundStyle(color(for: item.sdnn))
        }
        .frame(height: 196)
        .chartYScale(domain: 0...150)
        .chartXScale(domain: xScaleDomain)
        .chartYAxis {
            AxisMarks(position: .leading, values: [0, 25, 50, 75, 100, 125]) {
                AxisGridLine()
                    .foregroundStyle(Color.black.opacity(0.3))
                AxisValueLabel()
                    .foregroundStyle(Color.black.opacity(0.3))
            }
        }
        .chartXAxis {
            AxisMarks(values: ["00","03","06","09","12","15","18","21"]) {
                AxisValueLabel(centered: true)
                    .foregroundStyle(.black.opacity(0.3))
            }
        }
        .chartScrollableAxes(.horizontal)
    }
    
    func color(for yValue: Double) -> Color {
        switch yValue {
        case 0...10:
            return .bad
        case 11...30:
            return .caution
        case 31...60:
            return .normal
        default:
            return .good
        }
    }
}


extension BarChart {
    var xScaleDomain: [String] {
        return (0..<24).map { String(format: "%02d", $0) }
    }
}

