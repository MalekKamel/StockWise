//
// Created by Kamel on 27/02/2023.
//

import SwiftUI

struct RemoveListSeparator: ViewModifier {
    let color: Color

    func body(content: Content) -> some View {
        Group {
            if #available(iOS 15, *) {
                content.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .listRowInsets(EdgeInsets())
                        .background(color)
                        .listRowSeparator(.hidden)
            } else {
                content.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .listRowInsets(EdgeInsets())
                        .background(color)
            }
        }
    }
}

public extension View {
    func removeListSeparator(color: Color) -> some View {
        ModifiedContent(content: self, modifier: RemoveListSeparator(color: color))
    }
}