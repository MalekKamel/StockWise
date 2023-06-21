//
// Created by Kamel on 06/03/2023.
//

import SwiftUI

public extension View {

    func appShadow(radius: CGFloat = 4, fillColor: Color = .white) -> some View {
        cornerRadius(radius)
                .background(
                        RoundedRectangle(cornerRadius: radius, style: .continuous)
                                .fill(fillColor)
                                .shadow(color: .black.opacity(0.2), radius: 3)
                )
                .padding(3)
    }

}
