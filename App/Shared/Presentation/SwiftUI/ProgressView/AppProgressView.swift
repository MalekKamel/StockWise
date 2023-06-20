//
// Created by Kamel on 30/03/2023.
//

import SwiftUI

struct AppProgressView: View {
    let value: Float

    var body: some View {
        ProgressView(value: value, total: 100)
                .background(AppColor.gray6)
                .clipShape(Capsule())
                .scaleEffect(x: 1, y: 1.5, anchor: .center)
    }
}
