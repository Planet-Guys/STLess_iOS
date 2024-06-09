//
//  StressLevel.swift
//  STLess
//
//  Created by iOS신상우 on 5/27/24.
//

import SwiftUI

enum StressLevel {
    case bad
    case caution
    case normal
    case good
    case none
    
    var color: Color {
        switch self {
        case .bad:
            return .bad
        case .caution:
            return .caution
        case .normal:
            return .normal
        case .good:
            return .good
        case .none:
            return .black
        }
    }
    
    var icon: Image {
        switch self {
        case .bad:
            return .images(.badDust)
        case .caution:
            return .images(.cautionDust)
        case .normal:
            return .images(.normalDust)
        case .good:
            return .images(.goodDust)
        case .none:
            return .images(.noneDust)
        }
    }
    
    var bubble: Image {
        switch self {
        case .bad:
            return .images(.badCommentBubble)
        case .caution:
            return .images(.cautionCommentBubble)
        case .normal:
            return .images(.normalCommentBubble)
        case .good:
            return .images(.goodCommentBubble)
        case .none:
            return .images(.noneCommentBubble)
        }
    }
    
    var comment: Image {
        switch self {
        case .bad:
            return .images(.badComment)
        case .caution:
            return .images(.cautionComment)
        case .normal:
            return .images(.normalComment)
        case .good:
            return .images(.goodComment)
        case .none:
            return .images(.badDust)
        }
    }
    
    var title: String {
        switch self {
        case .bad:
            "지금 스트레스를 받고 계신 것 같아요!"
        case .caution:
            "스트레스 관리를 해볼까요?"
        case .normal:
            "지금 아주 잘하고 있어요!"
        case .good:
            "스트레스가 전혀 없으신 것 같아요!"
        case .none:
            "스트레스를 판단할 데이터가 없어요"
        }
    }
    
    var message: String {
        switch self {
        case .bad:
            "명상을 하거나 숨을 천천히 내쉬며\n잠깐의 여유를 가져보세요."
        case .caution:
            "사소한 일이라도 좋아요\n즐거웠던 일 한 가지를 떠올려보세요."
        case .normal:
            "스트레스가 없어지는 그날까지\n화이팅!"
        case .good:
            "오늘 하루, 세상에서 가장\n행복한 사람은 바로 당신일 거예요."
        case .none:
            "건강앱의 데이터 접근을 허용해주세요."
        }
    }
    
    var range: ClosedRange<Int> {
        switch self {
        case .bad:
            1...10
        case .caution:
            11...30
        case .normal:
            31...60
        case .good:
            61...120
        default:
            0...150
        }
    }
    
    var comment: String {
        switch self {
        case .bad:
            "아..스트레스"
        case .caution:
            "주의가 필요해"
        case .normal:
            "괜찮은 하루!"
        case .good:
            "최고야!"
        case .none:
            ""
        }
    }
}
