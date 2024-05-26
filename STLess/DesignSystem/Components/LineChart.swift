//
//  LineChart.swift
//  STLess
//
//  Created by iOS신상우 on 5/15/24.
//

import SwiftUI
import Charts

struct LineChart: View {
    let items: [DailySDNNInfo]
    
    @State private var selectedX = 1
    
    var body: some View {
        Chart(items) { item in
            LineMark(x: .value("hour", item.date),
                     y: .value("hrv", item.sdnn))
            .symbol() {
                Circle()
                    .fill()
                    .frame(width: 6)
            }
        }
        .frame(height: 196)
        .chartYAxis {
            AxisMarks(position: .leading, values: [0, 25, 50, 75, 100, 125]) {
                AxisGridLine()
                    .foregroundStyle(Color.black.opacity(0.3))
                AxisValueLabel()
                    .foregroundStyle(Color.black.opacity(0.3))
            }
        }
        .chartYScale(domain: 0...125)
        .chartXScale(domain: xScaleDomain)
        .chartXAxis {
            AxisMarks(values: stride(from: 0, through: 21, by: 3).map { hour in
                Calendar.current.date(bySettingHour: hour, minute: 0, second: 0, of: .now)!
            }) { value in
                AxisValueLabel(format: .dateTime.hour(.twoDigits(amPM: .omitted)), centered: true)
                    .foregroundStyle(.black.opacity(0.3))
            }
        }
        .chartScrollableAxes(.horizontal)
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

extension LineChart {
    var xScaleDomain: ClosedRange<Date> {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: .now)
        let start = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: startOfDay)!
        let end = calendar.date(bySettingHour: 21, minute: 0, second: 0, of: startOfDay)!
        return start...end
    }
}


#Preview {
    LineChart(items: [])
}
