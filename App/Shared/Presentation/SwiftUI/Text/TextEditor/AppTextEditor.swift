//
// Created by Kamel on 05/12/2022.
// Copyright (c) 2022 sha. All rights reserved.
//

import SwiftUI

public struct AppTextEditor: View {
    @Binding private var text: String
    private var placeholder: String
    private let radius: CGFloat

    public init(
            text: Binding<String>,
            placeholder: String = "",
            radius: CGFloat = 5
    ) {
        self._text = text
        self.placeholder = placeholder
        self.radius = radius
    }

    public var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color.white)

            TextEditor(text: $text)
                    .background(Color.clear)
                    .padding(.horizontal, 16)

            if !placeholder.isEmpty, text.isEmpty {
                Text(placeholder)
                        .appFont(size: 16)
                        .foregroundColor(Color(UIColor.placeholderText))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
            }
        }
                .appShadow()
    }
}

struct AppTextEditor_Previews: PreviewProvider {
    static var previews: some View {
        AppTextEditor(
                text: .constant(""),
                placeholder: "Placeholder",
                radius: 8)
                .frame(height: 180)
                .padding()
    }
}
