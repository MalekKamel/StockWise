//
// Created by Kamel on 11/04/2023.
//

import SwiftUI

public struct HScrollView<Content: View>: View {
    var content: Content
    @Environment(\.layoutDirection) private var layoutDirection

    public init(content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            content
                    .rotation3DEffect(Angle(
                            degrees: layoutDirection == .rightToLeft ? -180 : 0),
                            axis: (x: CGFloat(0), y: CGFloat(AppLanguage.layoutDirection == .rightToLeft ? -10 : 0), z: CGFloat(0)))

        }
                .rotation3DEffect(Angle(
                        degrees: layoutDirection == .rightToLeft ? 180 : 0),
                        axis: (x: CGFloat(0), y: CGFloat(AppLanguage.layoutDirection == .rightToLeft ? 10 : 0), z: CGFloat(0)))
    }
}


