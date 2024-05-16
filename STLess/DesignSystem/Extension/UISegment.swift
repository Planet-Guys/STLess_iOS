//
//  UISegment.swift
//  STLess
//
//  Created by iOS신상우 on 5/15/24.
//

import UIKit

extension UISegmentedControl {
    override open func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.setContentHuggingPriority(.defaultLow, for: .vertical)  // << here !!
    }
}
