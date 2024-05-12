//
//  Font+.swift
//  STLess
//
//  Created by iOS신상우 on 5/12/24.
//

import SwiftUI


extension Font {
    enum Pretendard: String {
        case medium = "Pretendard-Medium"
        case regular = "Pretendard-Regular"
        case semibold = "Pretendard-SemiBold"
        case bold = "Pretendard-Bold"
    }
    
    static func pretendard(size: CGFloat, style: Pretendard) -> Font {
        .custom(style.rawValue, size: size)
    }
    
    // MARK: Bold
    static let pdBold16: Font = .custom(Pretendard.bold.rawValue, size: 16)
    
    // MARK: SemiBold
    static let pdSemiBold16: Font = .custom(Pretendard.semibold.rawValue, size: 16)
    static let pdSemiBold18: Font = .custom(Pretendard.semibold.rawValue, size: 18)
    static let pdSemiBold24: Font = .custom(Pretendard.semibold.rawValue, size: 23)
    
    // MARK: Regular
    static let pdRegular11: Font = .custom(Pretendard.regular.rawValue, size: 11)
    static let pdRegular12: Font = .custom(Pretendard.regular.rawValue, size: 12)
    static let pdRegular14: Font = .custom(Pretendard.regular.rawValue, size: 14)
    
    // MARK: Medium
    static let pdMedium11: Font = .custom(Pretendard.medium.rawValue, size: 11)
    static let pdMedium12: Font = .custom(Pretendard.medium.rawValue, size: 12)
    static let pdMedium13: Font = .custom(Pretendard.medium.rawValue, size: 13)
    static let pdMedium14: Font = .custom(Pretendard.medium.rawValue, size: 14)
    static let pdMedium16: Font = .custom(Pretendard.medium.rawValue, size: 16)
}
