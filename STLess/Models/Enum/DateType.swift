//
//  DateType.swift
//  STLess
//
//  Created by iOS신상우 on 5/15/24.
//

import Foundation

enum DateType: CaseIterable, Equatable {
    case daily
    case weekly
    case monthly
    
    var name: String {
        switch self {
        case .daily:
            "일별"
        case .weekly:
            "주별"
        case .monthly:
            "월별"
        }
    }
    
    var period: Int {
        switch self {
        case .daily:
            return 1
        case .weekly:
            return 7
        case .monthly:
            return 0
        }
    }
    
    var interval: DateComponents {
        switch self {
        case .daily:
            DateComponents(hour: 1)
        case .weekly:
            DateComponents(day: 1)
        case .monthly:
            DateComponents(day: 1)
        }
    }
}
