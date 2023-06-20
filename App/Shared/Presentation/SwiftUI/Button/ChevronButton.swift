//
// Created by Kamel on 25/02/2023.
//

import SwiftUI

public struct ChevronButton<Label: View>: View {
    private let title: String
    private let action: () -> Void
    private let label: Label
    private let style: IconButtonStyle
    private let iconDirection: ChevronIconDirection

    public init(
            title: String = "",
            style: IconButtonStyle = .rounded,
            iconDirection: ChevronIconDirection = .down,
            action: @escaping () -> Void,
            @ViewBuilder label: () -> Label) {
        self.title = title
        self.style = style
        self.iconDirection = iconDirection
        self.action = action
        self.label = label()
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            if !title.isEmpty {
                Text(title)
                        .appFontBold(size: 14)
            }
            IconButton(
                    style: style,
                    action: action,
                    icon: {
                        Image(systemName: iconDirection.icon)
                                .foregroundColor(.black)
                    },
                    label: { label })
        }
    }
}

public enum ChevronIconDirection {
    case down
    case forward
    case backward

    var icon: AppSystemImage {
        switch self {
        case .down:
            return .chevronDown
        case .forward:
            return .chevronForward
        case .backward:
            return .chevronBackward
        }
    }
}
