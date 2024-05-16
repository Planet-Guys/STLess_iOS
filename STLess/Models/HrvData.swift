//
//  HrvData.swift
//  STLess
//
//  Created by iOS신상우 on 5/15/24.
//

import Foundation

struct HrvData: Identifiable {
    let hour: String
    let hrv: Int
    
    var id: String { hour }
}
