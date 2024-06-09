//
//  View+Keyboard.swift
//  STLess
//
//  Created by iOS신상우 on 6/8/24.
//

import SwiftUI

extension View {
    @ViewBuilder func hideKeyboardOnTapBackground(background: UIColor = UIColor.systemBackground) -> some View {
        self
            .background(
                Color(background)
                    .onTapGesture {
                        UIApplication.shared.endEditing()
                    }
            )
    }
}
