//
// Created by Kamel on 25/02/2023.
//

import SwiftUI

public struct IconButton<Label: View, Icon: View>: View {
    private let title: String
    private let action: () -> Void
    private let label: Label
    private let icon: Icon
    private let style: IconButtonStyle

    public init(
            title: String = "",
            style: IconButtonStyle = .rounded,
            action: @escaping () -> Void,
            @ViewBuilder icon: () -> Icon,
            @ViewBuilder label: () -> Label) {
        self.title = title
        self.style = style
        self.action = action
        self.icon = icon()
        self.label = label()
    }

    public var body: some View {
        Group {
            switch style {
            case .normal:
                Content()
            case .rounded:
                Content()
                        .padding(.horizontal)
                        .frame(height: 45)
                        .background(Color.white)
                        .appShadow()
            case .underline:
                VStack(spacing: 0) {
                    Content()
                    Divider()
                            .frame(height: 1)
                            .frame(maxWidth: .infinity)
                }
            }
        }
    }

    private func Content() -> some View {
        VStack(alignment: .leading, spacing: 15) {
            if !title.isEmpty {
                Text(title)
                        .appFontRegular(size: 12)
            }
            ButtonView()
        }
    }

    private func ButtonView() -> some View {
        Button(action: action) {
            ZStack {
                HStack {
                    Spacer()
                    icon
                }
                label
            }
        }
    }

}

public enum IconButtonStyle {
    case rounded
    case underline
    case normal
}
