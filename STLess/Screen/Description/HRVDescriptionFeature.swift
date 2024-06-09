//
//  HRVDescriptionFeature.swift
//  STLess
//
//  Created by iOS신상우 on 6/8/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct HRVDescriptionFeature {
    enum State {
        case main
    }
    
    enum Action {
        case main
        case delegate(Delegate)
        
        enum Delegate: Equatable {
            case back
        }
    }
    
    var reducer: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .main:
                return .none
            case .delegate(let action):
                switch action {
                case .back:
                    return .none
                }
            }
        }
    }
}

