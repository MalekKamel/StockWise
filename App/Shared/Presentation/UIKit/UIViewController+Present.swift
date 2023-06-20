//
// Created by Kamel on 08/09/2022.
// Copyright (c) 2022 sha. All rights reserved.
//

import SwiftUI

public extension UIViewController {

    func present<Content: View>(
            presentationStyle: UIModalPresentationStyle = .fullScreen,
            transitionStyle: UIModalTransitionStyle = .coverVertical,
            animated: Bool = true,
            completion: @escaping () -> Void = {
            },
            @ViewBuilder builder: () -> Content) {
        let toPresent = AppHostingController(rootView: builder())
        if presentationStyle == .overCurrentContext {
            toPresent.view.backgroundColor = .black.withAlphaComponent(0.3)
        }
        toPresent.modalPresentationStyle = presentationStyle
        onMainThread { [weak self] in
            guard let self = self else {
                return
            }
            self.present(toPresent, animated: animated, completion: completion)
        }
    }

}
