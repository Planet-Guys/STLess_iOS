//
//  WithDesignSystem.swift
//  STLess
//
//  Created by iOS신상우 on 6/8/24.
//

import SwiftUI

public struct WithDesignSystem<TopNavigation: View, Content: View, BottomButton: View>: View {

    let background: UIColor
    let topNavigation: TopNavigation
    let content: Content
    let bottomButton: BottomButton
    
    public init(
        _ background: UIColor = .white,
        topNavigation: () -> TopNavigation = { EmptyView() },
        content: () -> Content,
        bottomButton: () -> BottomButton = { EmptyView() }
    ) {
        self.background = background
        self.topNavigation = topNavigation()
        self.content = content()
        self.bottomButton = bottomButton()
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            topNavigation
            content
            Spacer(minLength: 0)
            bottomButton
        }
        .toolbar(.hidden, for: .navigationBar)
        .hideKeyboardOnTapBackground(background: background)
        .background(Color(uiColor: background))
    }
}
