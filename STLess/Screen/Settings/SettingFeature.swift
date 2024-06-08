//
//  SettingFeature.swift
//  STLess
//
//  Created by iOS신상우 on 6/1/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct SettingFeature {
    enum State: Equatable {
        case main
    }
    
    enum Action {
        case main
        case delegate(Delegate)
        
        enum Delegate: Equatable {
            case back
        }
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .main:
                return .none
            case .delegate(_):
                return .none
            }
        }
    }
}