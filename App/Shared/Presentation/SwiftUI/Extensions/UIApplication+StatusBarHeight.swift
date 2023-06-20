//
// Created by Kamel on 05/01/2023.
// Copyright (c) 2023 sha. All rights reserved.
//

import UIKit

public extension UIApplication {

    static var statusBarHeight: CGFloat {
        let window = UIApplication.shared
                .windows
                .filter {
                    $0.isKeyWindow
                }
                .first
        return window?.windowScene?
                .statusBarManager?
                .statusBarFrame
                .height ?? 0
    }

}
