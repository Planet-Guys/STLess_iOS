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
            case stressInfo(HRVDescriptionFeature.State)
        }
        
        enum Action {
            case setting(SettingFeature.Action)
            case stressInfo(HRVDescriptionFeature.Action)
        }
        
        var body: some Reducer<State, Action> {
            Scope(state: \.setting, action: \.setting, child: {
                SettingFeature()
            })
            Scope(state: \.stressInfo, action: \.stressInfo, child: {
                HRVDescriptionFeature()
            })
        }
        
        var navigationReducer: some Reducer<State, Action> {
            Reduce { state, action in
                switch action {
                default:
                    return .none
                }
            }
        }
    }
}
