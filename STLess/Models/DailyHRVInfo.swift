//
//  DailyHRVInfo.swift
//  STLess
//
//  Created by iOS신상우 on 5/19/24.
//

import Foundation

struct DailyHRVInfo: Identifiable, Equatable {
    let date: Date
    let sdnn: Double
    
    var id: String {
        date.formatted()
    }
}
