//
// Created by Kamel on 20/02/2023.
//

import SwiftUI

struct LazyView<Content: View>: View {
    private let build: () -> Content

    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }

    var body: Content {
        build()
    }
}

extension View {

    func toLazyView() -> some View {
        LazyView(self)
    }
}
