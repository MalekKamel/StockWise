//
// Created by Kamel on 21/07/2022.
// Copyright (c) 2022 sha. All rights reserved.
//

import SwiftUI

public struct ChevronTitleTextField: View {
    private let title: String
    private let placeholder: String
    @Binding var text: String

    public init(
            title: String = "",
            placeholder: String = "",
            text: Binding<String>) {
        self.title = title
        self.placeholder = placeholder
        _text = text
    }

    public var body: some View {
        ZStack(alignment: .trailing) {
            TitleTextField(
                    title: title,
                    placeholder: placeholder,
                    text: $text)

            Image(systemName: .chevronDown)
                    .resizable()
                    .frame(width: 8, height: 14)
                    .foregroundColor(.white)
        }
    }

}
