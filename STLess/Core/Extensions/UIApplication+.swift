//
//  UIApplication+.swift
//  STLess
//
//  Created by iOS신상우 on 6/8/24.
//

import SwiftUI

public extension UIApplication {
    
    var scene: UIWindowScene? {
        UIApplication
            .shared
            .connectedScenes
            .first as? UIWindowScene
    }
    
    var window: UIWindow? {
        scene?
            .windows
            .first(where: { $0.isKeyWindow })
    }
    
    var root: UIViewController? {
        window?.rootViewController
    }
    
    var screenSize: CGRect? {
        scene?.screen.bounds
    }
    
    func endEditing() {
        sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil, from: nil, for: nil
        )
    }
}