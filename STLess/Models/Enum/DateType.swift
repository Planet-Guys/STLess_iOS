//
//  DateType.swift
//  STLess
//
//  Created by iOS신상우 on 5/15/24.
//

import Foundation

enum DateType: CaseIterable {
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
}
