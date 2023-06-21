//
// Created by Kamel on 22/02/2023.
//

import Foundation
import IQKeyboardManagerSwift

struct AppKeyboardManager {
    static var enabled = true {
        didSet {
            IQKeyboardManager.shared.enable = enabled
        }
    }

    static func setup() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 10
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = Strings.done
    }

}
