//
// Created by Kamel on 20/04/2023.
//

import SwiftUI
import SwiftUINavigator

struct DismissButton: View {
    @EnvironmentObject private var navigator: Navigator

    var body: some View {
        Button {
            navigator.dismissSheet()
        } label: {
            Text(Strings.cancel)
                    .appFontBold(size: 16)
        }
    }

}
