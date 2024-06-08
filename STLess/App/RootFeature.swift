//
//  RootFeature.swift
//  STLess
//
//  Created by iOS신상우 on 6/1/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct RootFeature {
    
    @ObservableState
    enum State: Equatable {
        case main(MainFeature.State = .init())
        case splash(SplashFeature.State = .init())
        
        init() {
            self = .splash(.init())
        }
    }
    
    enum Action {
        case _changeScreen(State)
        case splash(SplashFeature.Action)
        case main(MainFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .main:
                return .none
            case .splash(let action):
                switch action {
                case ._onAppear:
                    return .run(priority: .userInitiated) { send in
                        try await Task.sleep(for: .seconds(1.5))
                        await send(._changeScreen(.main(.init())), animation: .spring)
                    }
                }
            case let ._changeScreen(newState):
                state = newState
                return .none
            }
        }
        .ifCaseLet(\.splash, action: \.splash) { SplashFeature() }
        .ifCaseLet(\.main, action: \.main) { MainFeature() }
    }
        
}
