//
//  Utils.swift
//  STLess
//
//  Created by iOS신상우 on 5/20/24.
//

import Foundation

struct Utils {
    static var xAxisValuesDaily: [Date] {
         let calendar = Calendar.current
         var dates: [Date] = []
         let now = Date()
         
         for hour in stride(from: 0, to: 24, by: 3) {
             if let date = calendar.date(bySettingHour: hour, minute: 0, second: 0, of: now) {
                 dates.append(date)
             }
         }
         return dates
     }
}
