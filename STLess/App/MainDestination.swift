//
//  MainDestination.swift
//  STLess
//
//  Created by iOS신상우 on 6/1/24.
//

import Foundation
import ComposableArchitecture

extension RootFeature {
    @Reducer(state: .equatable)
    enum Destination {
        case main
        case login
        case splash
    }
}
