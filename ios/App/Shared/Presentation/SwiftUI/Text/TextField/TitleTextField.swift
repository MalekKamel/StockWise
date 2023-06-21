//
// Created by Kamel on 21/07/2022.
// Copyright (c) 2022 sha. All rights reserved.
//

import SwiftUI

public struct TitleTextField: View {
    private let title: String
    private let placeholder: String
    private let spacing: CGFloat
    @Binding var text: String
    private let hasSpecialCharacters: Bool
    private let keyboardType: UIKeyboardType

    public init(
            title: String = "",
            placeholder: String = "",
            spacing: CGFloat = 15,
            text: Binding<String>,
            hasSpecialCharacters: Bool = true,
            keyboardType: UIKeyboardType = .default
            ) {
        self.title = title
        self.placeholder = placeholder
        self.spacing = spacing
        _text = text
        self.hasSpecialCharacters = hasSpecialCharacters
        self.keyboardType = keyboardType
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            Text(title)
                    .appFontRegular(size: 14)
            AppTextField(
                    placeholder, text: $text,
                    keyboardType: keyboardType,
                    hasSpecialCharacters: hasSpecialCharacters)
                    .frame(height: 45)
        }
    }

}
