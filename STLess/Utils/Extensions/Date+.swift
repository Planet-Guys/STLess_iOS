//
//  Date+.swift
//  STLess
//
//  Created by iOS신상우 on 5/19/24.
//

import SwiftUI

extension Date {
    static var anchorDate: Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: .now)
        components.hour = 0
        components.minute = 0
        components.second = 0
        
        return calendar.date(from: components) ?? .now
    }
    
    var fullDateString: String {
        return self.formatted(date: .long, time: .standard)
    }
}
