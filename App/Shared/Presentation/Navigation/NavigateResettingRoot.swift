//
// Created by Kamel on 22/02/2023.
//

import SwiftUI
import SwiftUINavigator

public func navigate<T: View>(swappingRootController rootView: T) {
    let navView = NavView(showDefaultNavBar: false) {
        rootView
    }
    onMainThread {
        RootWindow.reset(to: navView)
    }
}
