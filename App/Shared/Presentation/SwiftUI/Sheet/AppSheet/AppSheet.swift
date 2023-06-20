//
// Created by Kamel on 07/03/2023.
//

import SwiftUI
import SwiftUINavigator

struct AppSheet<Content: View>: View {
    private let withDismissButton: Bool
    private let content: Content
    @ObservedObject private var keyboard = KeyboardGuardian.shared

    init(withDismissButton: Bool = false, content: () -> Content) {
        self.withDismissButton = withDismissButton
        self.content = content()
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack {
                Capsule()
                        .fill(AppColor.gray)
                        .frame(width: 100, height: 6)
                        .padding(.top, 8)
                Spacer().frame(height: withDismissButton ? 40 : 16)

                Spacer().frame(height: keyboard.currentHeight / 4)
                content.infiniteSize()
            }
            if withDismissButton {
                HStack {
                    Spacer()
                    DismissButton()
                }
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
            }
        }
                .background(Color.white)
                .infiniteSize()
                .cornerRadius(12, corners: [.topLeft, .topRight])
    }
}
