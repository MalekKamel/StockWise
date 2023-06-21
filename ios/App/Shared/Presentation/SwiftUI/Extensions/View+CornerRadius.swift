//
// Created by Kamel on 07/03/2023.
//

import SwiftUI

public extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

public extension View {
    func cornerRadiusStroke<S>(
            _ radius: CGFloat,
            corners: UIRectCorner,
            stroke: S,
            lineWidth: CGFloat = 1
    ) -> some View where S: ShapeStyle {
        overlay(RoundedCorner(radius: radius, corners: corners)
                .stroke(stroke, lineWidth: lineWidth))
    }
}

public struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    public func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
                roundedRect: rect,
                byRoundingCorners: corners,
                cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
