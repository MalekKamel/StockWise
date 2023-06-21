//
// Created by Kamel on 07/09/2022.
// Copyright (c) 2022 sha. All rights reserved.
//

import SwiftUI

public struct AppActivityIndicator {
    private static let loadingViewTag = 4875618

    public static func show(
            allowTouchOutside: Bool = true,
            deadLine: DispatchTime,
            position: Position = .center,
            presenter: PresenterController = .top) {
        show(allowTouchOutside: allowTouchOutside)
        DispatchQueue.main.asyncAfter(deadline: deadLine) {
            hide()
        }
    }

    public static func show(
            allowTouchOutside: Bool = true,
            position: Position = .center,
            presenter: PresenterController = .top) {
        DispatchQueue.main.async {
            let viewController: UIViewController?

            switch presenter {
            case .root:
                viewController = UIApplication.shared.rootController
            case .top:
                viewController = UIApplication.shared.topViewController()
            }

            guard let viewController else {
                return
            }

            let indicator: UIView = AppHostingController(rootView: IndicatorView(position: position)).view
            indicator.tag = loadingViewTag

            if !allowTouchOutside {
                indicator.frame = viewController.view.frame
            }
            indicator.center = viewController.view.center
            viewController.view.addSubview(indicator)
            indicator.pinEdges(to: viewController.view)
        }
    }

    private static func IndicatorView(position: Position) -> some View {
        VStack {
            switch position {
            case .center:
                Spacer().infiniteSize()
                Spinner(style: .large)
                Spacer().infiniteSize()
            case .top(let margin):
                Spacer().frame(height: margin)
                Spinner(style: .large)
                Spacer().infiniteSize()
            case .bottom(let margin):
                Spacer().infiniteSize()
                Spinner(style: .large)
                Spacer().frame(height: margin)
            }
        }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }

    public static func hide() {
        DispatchQueue.main.async {
            while let effectView = UIApplication.shared.topViewController()?.view.viewWithTag(loadingViewTag) {
                effectView.removeFromSuperview()
            }
            while let effectView = UIApplication.rootViewController?.view.viewWithTag(loadingViewTag) {
                effectView.removeFromSuperview()
            }
        }
    }
}

public extension AppActivityIndicator {

    enum Position {
        case center
        case top(margin: CGFloat)
        case bottom(margin: CGFloat)
    }

}

public extension AppActivityIndicator {

    enum PresenterController {
        case root
        case top
    }

}

extension UIView {

    func pinEdges(to other: UIView) {
        widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height).isActive = true
    }
}
