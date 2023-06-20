//
// Created by Kamel on 01/07/2022.
// Copyright (c) 2022 sha. All rights reserved.
//

import SwiftUI

public enum TextFieldAction {
    case copy
    case paste
    case cut
    case delete
    case select
    case selectAll
    case unknown

    static func from(selector: Selector) -> TextFieldAction {
        if selector == #selector(UIResponderStandardEditActions.copy(_:)) {
            return .copy
        }

        if selector == #selector(UIResponderStandardEditActions.paste(_:)) {
            return .paste
        }

        if selector == #selector(UIResponderStandardEditActions.cut(_:)) {
            return .cut
        }

        if selector == #selector(UIResponderStandardEditActions.delete(_:)) {
            return .delete
        }

        if selector == #selector(UIResponderStandardEditActions.select(_:)) {
            return .select
        }

        if selector == #selector(UIResponderStandardEditActions.selectAll(_:)) {
            return .selectAll
        }
        return .unknown
    }
}

public struct AppUITextField: UIViewRepresentable {
    private let title: String
    private let hasSpecialCharacters: Bool
    @Binding private var text: String
    private let keyboardType: UIKeyboardType
    private let disabledActions: [TextFieldAction]
    private let charsLimit: Int?
    private let textAlignment: NSTextAlignment?
    private let onEditingChanged: (Bool) -> Void
    private let onCommit: () -> Void

    public init(
            _ title: String,
            text: Binding<String>,
            keyboardType: UIKeyboardType = .default,
            disabledActions: [TextFieldAction] = [],
            charsLimit: Int? = nil,
            textAlignment: NSTextAlignment? = nil,
            hasSpecialCharacters: Bool = true,
            onEditingChanged: @escaping (Bool) -> Void,
            onCommit: @escaping () -> Void) {
        self.title = title
        _text = text
        self.keyboardType = keyboardType
        self.disabledActions = disabledActions
        self.charsLimit = charsLimit
        self.textAlignment = textAlignment
        self.hasSpecialCharacters = hasSpecialCharacters
        self.onEditingChanged = onEditingChanged
        self.onCommit = onCommit
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    public func makeUIView(context: UIViewRepresentableContext<AppUITextField>) -> UITextField {
        let textField = ActionsUITextField()
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        textField.text = text
        textField.disabledActions = disabledActions
        textField.delegate = context.coordinator
        textField.attributedPlaceholder = NSAttributedString(
                string: title,
                attributes: [
                    .foregroundColor: UIColor.placeholderText,
                    .font: UIFont.systemFont(ofSize: 16)
                ])
        textField.keyboardType = keyboardType
        if let alignment = textAlignment {
            textField.textAlignment = alignment
        }
        SemanticContentHelper.apply(for: textField)
        return textField
    }

    public func updateUIView(_ uiView: UITextField, context: Context) {

    }

    public class Coordinator: NSObject, UITextFieldDelegate {
        var parent: AppUITextField

        public init(_ textField: AppUITextField) {
            parent = textField
        }

        public func textFieldDidChangeSelection(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }

        public func textFieldDidBeginEditing(_ textField: UITextField) {
            parent.onEditingChanged(true)
        }

        public func textFieldDidEndEditing(_ textField: UITextField) {
            parent.onEditingChanged(false)
            parent.onCommit()
        }

        public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if !shouldBeAlphabetOnly(string: string) {
                return false
            }

            guard let limit = parent.charsLimit else {
                return true
            }
            // get the current text, or use an empty string if that failed
            let currentText = textField.text ?? ""

            // attempt to read the range they are trying to change, or exit if we can't
            guard let stringRange = Range(range, in: currentText) else {
                return false
            }

            // add their new text to the existing text
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

            // make sure the result is under 16 characters
            return updatedText.count <= limit
        }

        private func shouldBeAlphabetOnly(string: String) -> Bool {
            guard !parent.hasSpecialCharacters else {
                return true
            }
            // Allow space
            guard string != " " else {
                return true
            }
            // Allow numbers
            guard !string.isNumber else {
                return true
            }
            // Allow letters
            return string.isLetters
        }

        public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            parent.onCommit()
            return true
        }
    }


}

class ActionsUITextField: UITextField {
    var disabledActions: [TextFieldAction] = []

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        let type = TextFieldAction.from(selector: action)
        let isActionDisabled = disabledActions.contains(type)
        return isActionDisabled ? false : super.canPerformAction(action, withSender: sender)
    }
}

