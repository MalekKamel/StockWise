//
// Created by Kamel on 06/03/2023.
//

import SwiftUI

public extension View {

    func appBorder(color: Color, lineWidth: CGFloat = 1) -> some View {
        overlay(RoundedRectangle(cornerRadius: 6, style: .continuous)
                .strokeBorder(color, lineWidth: lineWidth))
    }

    func appCircleBorder(color: Color, fillColor: Color, lineWidth: CGFloat = 1) -> some View {
        background(
                Circle()
                        .strokeBorder(color, lineWidth: 2)
                        .background(fillColor)
                        .clipShape(Circle())
        )
    }

}
