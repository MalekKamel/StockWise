//
// Created by Kamel on 01/03/2023.
//

import UIKit

public class SemanticContentHelper {

    public static func apply(for view: UIView) {
        switch AppLanguage.current {
        case .en:
            forceLtr(for: view)
        }
    }

    public static func apply(for view: UITextField) {
        switch AppLanguage.current {
        case .en:
            forceLtr(for: view)
        }
    }

    public static func forceRtl(for view: UIView) {
        view.semanticContentAttribute = .forceRightToLeft
    }

    public static func forceLtr(for view: UIView) {
        view.semanticContentAttribute = .forceLeftToRight
    }

    public static func forceRtl(for view: UITextField) {
        view.semanticContentAttribute = .forceRightToLeft
        view.textAlignment = .right
    }

    public static func forceLtr(for view: UITextField) {
        view.semanticContentAttribute = .forceLeftToRight
        view.textAlignment = .left
    }

    public static func forceLtr() {
        force(.forceLeftToRight)
    }

    public static func forceRtl() {
        force(.forceRightToLeft)
    }

    private static func force(_ attribute: UISemanticContentAttribute) {
        UIView.appearance().semanticContentAttribute = attribute
        UINavigationBar.appearance().semanticContentAttribute = attribute
        UIButton.appearance().semanticContentAttribute = attribute
        UITextView.appearance().semanticContentAttribute = attribute
        UITextField.appearance().semanticContentAttribute = attribute
    }
}
