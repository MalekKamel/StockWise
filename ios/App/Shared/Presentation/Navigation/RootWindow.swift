//
// Created by Kamel on 22/02/2023.
//

import SwiftUI

public struct RootWindow {
    public static func reset<V: View>(to rootView: V) {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            return
        }
        sceneDelegate.setupRootWindow(rootView: rootView)
    }
}

