//
//  RootView.swift
//  STLess
//
//  Created by iOS신상우 on 6/1/24.
//

import SwiftUI
import ComposableArchitecture

struct RootView: View {
    private let store: StoreOf<RootFeature>
    
    init(store: StoreOf<RootFeature>) {
        self.store = store
    }
    
    enum State: Equatable {
        case splash(SplashFeature.State = .init())
        case main(MainFeature.State = .init())
        
        init() { self = .splash(.init()) }
    }
    
    var body: some View {
        Group {
            switch store.state {
            case .splash:
                if let store = store.scope(state: \.splash, action: \.splash) {
                    SplashView(store: store)
                }

            case .main:
                if let store = store.scope(state: \.main, action: \.main) {
                    MainView(store: store)
                }
            }
        }
        .animation(.spring, value: store.state)
    }
}
