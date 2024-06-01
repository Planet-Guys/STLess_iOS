//
//  SplashFeature.swift
//  STLess
//
//  Created by iOS신상우 on 6/1/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct SplashFeature {
    
    @ObservableState
    struct State: Equatable {

    }
    
    enum Action {
        case _onAppear
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case ._onAppear:
                return .none
            }
        }
    }
}
