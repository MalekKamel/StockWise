//
// Created by Kamel on 24/10/2022.
// Copyright (c) 2022 sha. All rights reserved.
//

import UIKit

public extension UIApplication {

    var rootController: UIViewController? {
        mainWindow?.rootViewController
    }

    func topViewController(controller: UIViewController? = UIApplication.shared.mainWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController, let selected = tabController.selectedViewController {
            return topViewController(controller: selected)
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }

    var mainWindow: UIWindow? {
        UIApplication.shared.connectedScenes
                .filter({ $0.activationState == .foregroundActive })
                .compactMap({ $0 as? UIWindowScene })
                .first?
                .windows
                .filter({ $0.isKeyWindow })
                .last
    }

    var bottomAnchor: CGFloat {
        mainWindow?.safeAreaInsets.bottom ?? 0
    }

    var topAnchor: CGFloat {
        mainWindow?.safeAreaInsets.top ?? 0
    }
}
