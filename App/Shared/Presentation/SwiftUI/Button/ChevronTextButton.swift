//
// Created by Kamel on 25/02/2023.
//

import SwiftUI

public struct ChevronTextButton: View {
    private let title: String
    private let text: String
    private let action: () -> Void
    private let style: IconButtonStyle
    private let iconDirection: ChevronIconDirection

    public init(
            title: String = "",
            text: String = "",
            style: IconButtonStyle = .rounded,
            iconDirection: ChevronIconDirection = .down,
            action: @escaping () -> Void) {
        self.title = title
        self.text = text
        self.style = style
        self.iconDirection = iconDirection
        self.action = action
    }

    public var body: some View {
        ChevronButton(
                title: title,
                style: style,
                iconDirection: iconDirection,
                action: action) {
            Text(text)
                    .appFont(size: 16)
                    .foregroundColor(.black)
        }
    }
}

