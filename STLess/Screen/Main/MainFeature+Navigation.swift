//
//  MainFeature+Navigation.swift
//  STLess
//
//  Created by iOS신상우 on 6/1/24.
//

import ComposableArchitecture

extension MainFeature {
    @Reducer
    struct MainNaviagtionPath {
        @ObservableState
        enum State: Equatable {
            case setting(SettingFeature.State)
            case stressInfo
        }
        
        enum Action {
            case setting(SettingFeature.Action)
            case stressInfo
        }
        
        var body: some Reducer<State, Action> {
            Scope(state: \.setting, action: \.setting, child: {
                SettingFeature()
            })
        }
        
        var navigationReducer: some Reducer<State, Action> {
            Reduce { state, action in
                switch action {
                default:
                    print("ss")
                    return .none
                }
            }
        }
    }
}
