//
// Created by Kamel on 30/06/2022.
// Copyright (c) 2022 sha. All rights reserved.
//

import SwiftUI

public struct AppTextField<LeadingView: View, TrailingView: View>: View {
    public enum Style {
        case normal
        case rounded
        case capsule
        case outlined
        case underline
    }

    private let title: String
    @Binding private var text: String
    private let style: Style
    private let height: CGFloat
    private let backgroundColor: Color
    let keyboardType: UIKeyboardType
    private let disabledActions: [TextFieldAction]
    private let charsLimit: Int?
    private let textAlignment: NSTextAlignment?
    private let hasSpecialCharacters: Bool
    private let radius: CGFloat
    @State private var isEditing: Bool = false
    var onEditingChanged: (Bool) -> () = { _ in
    }
    var onCommit: () -> () = {
    }
    private let leadingView: () -> LeadingView
    private let trailingView: () -> TrailingView

    public init(
            _ title: String = "",
            text: Binding<String>,
            height: CGFloat = 45,
            backgroundColor: Color = AppColor.gray2,
            style: Style = .capsule,
            keyboardType: UIKeyboardType = .default,
            disabledActions: [TextFieldAction] = [],
            charsLimit: Int? = nil,
            textAlignment: NSTextAlignment? = nil,
            hasSpecialCharacters: Bool = true,
            radius: CGFloat = 5,
            onEditingChanged: @escaping (Bool) -> Void = { _ in
            },
            onCommit: @escaping () -> Void = {
            },
            leadingView: @escaping () -> LeadingView,
            trailingView: @escaping () -> TrailingView
    ) {
        self.title = title
        self._text = text
        self.height = height
        self.backgroundColor = backgroundColor
        self.style = style
        self.keyboardType = keyboardType
        self.disabledActions = disabledActions
        self.charsLimit = charsLimit
        self.textAlignment = textAlignment
        self.hasSpecialCharacters = hasSpecialCharacters
        self.radius = radius
        self.onEditingChanged = onEditingChanged
        self.onCommit = onCommit
        self.leadingView = leadingView
        self.trailingView = trailingView
    }

    public var body: some View {
        Group {
            switch style {
            case .normal:
                Content()
            case .rounded:
                Content()
                        .padding(.horizontal)
                        .background(backgroundColor)
                        .cornerRadius(4)
            case .capsule:
                Content()
                        .padding(.horizontal)
                        .background(backgroundColor)
                        .clipShape(Capsule())
            case .outlined:
                Content()
                        .padding(.vertical, 8)
                        .padding(.horizontal, 8.5)
                        .appBorder(color: AppColor.gray4)
            case .underline:
                VStack(spacing: 0) {
                    Content()
                    Divider()
                            .frame(height: 1)
                            .infiniteWidth()
                }
            }
        }
    }

    private func Content() -> some View {
        HStack(spacing: 0) {
            leadingView()
            FieldView()
            trailingView()
        }
    }

    private func FieldView() -> some View {
        AppUITextField(
                title,
                text: $text,
                keyboardType: keyboardType,
                disabledActions: disabledActions,
                charsLimit: charsLimit,
                textAlignment: textAlignment,
                hasSpecialCharacters: hasSpecialCharacters,
                onEditingChanged: {
                    onEditingChanged($0)
                    isEditing = $0
                },
                onCommit: onCommit)
                .frame(height: height)
    }

}

public extension AppTextField where LeadingView == EmptyView, TrailingView == EmptyView {

    init(
            _ title: String = "",
            text: Binding<String>,
            height: CGFloat = 45,
            backgroundColor: Color = AppColor.gray2,
            style: Style = .capsule,
            keyboardType: UIKeyboardType = .default,
            disabledActions: [TextFieldAction] = [],
            charsLimit: Int? = nil,
            textAlignment: NSTextAlignment? = nil,
            hasSpecialCharacters: Bool = true,
            radius: CGFloat = 5,
            onEditingChanged: @escaping (Bool) -> Void = { _ in
            },
            onCommit: @escaping () -> Void = {
            }
    ) {
        self.title = title
        self._text = text
        self.height = height
        self.backgroundColor = backgroundColor
        self.style = style
        self.keyboardType = keyboardType
        self.disabledActions = disabledActions
        self.charsLimit = charsLimit
        self.textAlignment = textAlignment
        self.hasSpecialCharacters = hasSpecialCharacters
        self.radius = radius
        self.onEditingChanged = onEditingChanged
        self.onCommit = onCommit
        leadingView = {
            EmptyView()
        }
        trailingView = {
            EmptyView()
        }
    }

}

public extension AppTextField where TrailingView == EmptyView {

    init(
            _ title: String = "",
            text: Binding<String>,
            height: CGFloat = 45,
            backgroundColor: Color = AppColor.gray2,
            style: Style = .capsule,
            keyboardType: UIKeyboardType = .default,
            disabledActions: [TextFieldAction] = [],
            charsLimit: Int? = nil,
            textAlignment: NSTextAlignment? = nil,
            hasSpecialCharacters: Bool = true,
            radius: CGFloat = 5,
            onEditingChanged: @escaping (Bool) -> Void = { _ in
            },
            onCommit: @escaping () -> Void = {
            },
            leadingView: @escaping () -> LeadingView
    ) {
        self.title = title
        self._text = text
        self.height = height
        self.backgroundColor = backgroundColor
        self.style = style
        self.keyboardType = keyboardType
        self.disabledActions = disabledActions
        self.charsLimit = charsLimit
        self.textAlignment = textAlignment
        self.hasSpecialCharacters = hasSpecialCharacters
        self.radius = radius
        self.onEditingChanged = onEditingChanged
        self.onCommit = onCommit
        self.leadingView = leadingView
        trailingView = {
            EmptyView()
        }
    }

}

public extension AppTextField where LeadingView == EmptyView {

    init(
            _ title: String = "",
            text: Binding<String>,
            height: CGFloat = 45,
            backgroundColor: Color = AppColor.gray2,
            style: Style = .capsule,
            keyboardType: UIKeyboardType = .default,
            disabledActions: [TextFieldAction] = [],
            charsLimit: Int? = nil,
            textAlignment: NSTextAlignment? = nil,
            hasSpecialCharacters: Bool = true,
            radius: CGFloat = 5,
            onEditingChanged: @escaping (Bool) -> Void = { _ in
            },
            onCommit: @escaping () -> Void = {
            },
            trailingView: @escaping () -> TrailingView
    ) {
        self.title = title
        self._text = text
        self.height = height
        self.backgroundColor = backgroundColor
        self.style = style
        self.keyboardType = keyboardType
        self.disabledActions = disabledActions
        self.charsLimit = charsLimit
        self.textAlignment = textAlignment
        self.hasSpecialCharacters = hasSpecialCharacters
        self.radius = radius
        self.onEditingChanged = onEditingChanged
        self.onCommit = onCommit
        leadingView = {
            EmptyView()
        }
        self.trailingView = trailingView
    }

}

struct AppTextField_Previews: PreviewProvider {
    static var previews: some View {
        AppTextField(
                text: .constant(""),
                style: .outlined,
                keyboardType: .phonePad,
                trailingView: {
                    Image(systemName: .personFill)
                            .resizable()
                            .frame(width: 20, height: 20)
                })
                .padding()
    }
}


