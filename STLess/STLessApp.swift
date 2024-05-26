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
    
    init() {
        HealthManager.share.configure()
    }
    var body: some Scene {
        WindowGroup {
            MainView(
                store: Store(initialState: MainFeature.State()) {
                    MainFeature()
                }
            )
        }
    }
}
