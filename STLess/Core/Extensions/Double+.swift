//
//  Double+.swift
//  STLess
//
//  Created by iOS신상우 on 5/27/24.
//

import Foundation

extension Double {
    var getStressLevel: StressLevel {
        switch self {
        case 1...10:
            return .bad
        case 11...30:
            return .caution
        case 31...60:
            return .normal
        case 61...120:
            return .good
        default:
            return .none
        }
    }
}
