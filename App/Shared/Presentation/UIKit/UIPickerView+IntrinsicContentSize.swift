//
// Created by Kamel on 10/08/2022.
// Copyright (c) 2022 sha. All rights reserved.
//

import SwiftUI

/// A solution for overlapping scroll of Picker view
/// https://developer.apple.com/forums/thread/687986
extension UIPickerView {
    open override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: super.intrinsicContentSize.height)
    }
}
