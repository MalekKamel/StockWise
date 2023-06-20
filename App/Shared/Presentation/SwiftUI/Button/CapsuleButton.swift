//
// Created by Kamel on 31/03/2023.
//

import SwiftUI

struct CapsuleButton: View {
    private let title: String
    private let action: () -> Void

    init(title: String,
         action: @escaping () -> ()) {
        self.title = title
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Text(title)
                    .appFont(size: 12)
                    .padding(.vertical, 13)
                    .padding(.horizontal, 20)
                    .frame(height: 40)
                    .foregroundColor(.white)
                    .background(AppColor.primary4)
                    .clipShape(Capsule())
        }
    }
}
