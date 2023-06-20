//
// Created by Kamel on 31/03/2023.
//

import SwiftUI

struct CapsuleBorderedButton<LeadingView: View>: View {
    private let title: String
    private let style: Style
    private let backgroundColor: Color
    private let leadingView: LeadingView
    private let action: () -> Void

    enum Style {
        case small
        case large

        var paddingHorizontal: CGFloat {
            switch self {
            case .small:
                return 8
            case .large:
                return 23
            }
        }

        var fontSize: CGFloat {
            switch self {
            case .small:
                return 12
            case .large:
                return 14
            }
        }
    }

    init(title: String,
         style: Style = .small,
         backgroundColor: Color = .white,
         @ViewBuilder leadingView: () -> LeadingView,
         action: @escaping () -> ()) {
        self.title = title
        self.style = style
        self.backgroundColor = backgroundColor
        self.leadingView = leadingView()
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack(alignment: .top, spacing: 6) {
                leadingView
                Text(title)
                        .appFont(size: style.fontSize)
                        .foregroundColor(AppColor.gray9)
            }
                    .padding(.horizontal, style.paddingHorizontal)
                    .padding(.vertical, 13)
                    .background(backgroundColor)
                    .cornerRadius(20)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(AppColor.gray8, lineWidth: 1))
                    .compositingGroup()
                    .shadow(color: AppColor.gray8, radius: 4, x: 0, y: 4)
        }
    }
}

extension CapsuleBorderedButton where LeadingView == EmptyView {

    init(title: String,
         style: Style = .small,
         backgroundColor: Color = .white,
         action: @escaping () -> ()) {
        self.title = title
        self.style = style
        self.backgroundColor = backgroundColor
        leadingView = EmptyView()
        self.action = action
    }

}
