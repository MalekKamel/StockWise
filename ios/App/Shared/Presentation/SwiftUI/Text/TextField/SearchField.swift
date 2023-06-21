//
// Created by Kamel on 13/10/2022.
// Copyright (c) 2022 sha. All rights reserved.
//

import SwiftUI

public struct SearchField: View {
    private let title: String
    @Binding private var text: String
    private let backgroundColor: Color
    private let hasSpecialCharacters: Bool
    private let onCommit: () -> ()

    public init(
            title: String,
            text: Binding<String>,
            backgroundColor: Color = AppColor.gray2,
            hasSpecialCharacters: Bool = true,
            onCommit: @escaping () -> Void = {
            }) {
        self.title = title
        _text = text
        self.backgroundColor = backgroundColor
        self.hasSpecialCharacters = hasSpecialCharacters
        self.onCommit = onCommit
    }

    public var body: some View {
        AppTextField(
                title,
                text: $text,
                backgroundColor: backgroundColor,
                hasSpecialCharacters: hasSpecialCharacters,
                onCommit: onCommit,
                leadingView: {
                    Image(systemName: .magnifyingGlass)
                            .resizable()
                            .frame(width: 21, height: 21)
                            .foregroundColor(AppColor.gray)
                            .padding(.trailing, 8)
                })
    }
}
