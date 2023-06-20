//
// Created by Kamel on 25/02/2023.
//

import SwiftUI

struct AppButton: View {
    private let title: String
    private let action: () -> Void

    init(title: String, action: @escaping () -> ()) {
        self.title = title
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Text(title)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .appFont(size: 14)
                    .frame(height: 45)
                    .padding(.horizontal, 15)
                    .background(AppColor.primary2)
                    .cornerRadius(6)
        }
    }
}
