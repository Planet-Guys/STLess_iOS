//
//  Date+.swift
//  STLess
//
//  Created by iOS신상우 on 5/29/24.
//

import Foundation

extension Date {
    static var anchorDate: Date {
        var components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: .now)
        components.hour = 0
        components.minute = 0
        components.second = 0
        
        return components.date ?? .now
    }
    
    func startOfDay(dayOffset: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .day, value: dayOffset, to: self) ?? .now
    }
}
