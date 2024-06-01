//
//  STLessApp.swift
//  STLess
//
//  Created by iOS신상우 on 4/21/24.
//

import SwiftUI
import ComposableArchitecture

@main
struct STLessApp: App {
    let store = Store(initialState: RootFeature.State.init(), reducer: {
        RootFeature()
    })
    
    init() {
        HealthManager.share.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RootView(store: store)
            }
        }
    }
}
