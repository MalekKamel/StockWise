//
// Created by Kamel on 05/01/2023.
// Copyright (c) 2023 sha. All rights reserved.
//

import SwiftUI

public struct AppMessageView: View {
    private let message: String
    private let type: MessageViewType

    public init(message: String, type: MessageViewType) {
        self.message = message
        self.type = type
    }

    public var body: some View {
        VStack(spacing: 0) {
            switch type {
            case .success:
                SuccessView()
            case .error:
                ErrorView()
            }
        }
                .padding(15)
                .background(type.color)
    }

    private func SuccessView() -> some View {
        HStack {
            Spacer()
            Text(message)
                    .multilineTextAlignment(.center)
                    .appFontBold(size: 14)
                    .foregroundColor(.white)
            Spacer()
        }
    }

    private func ErrorView() -> some View {
        HStack(spacing: 0) {
            Spacer()
            Image(systemName: .exclamationMarkCircleFill)
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 25, height: 25)
            Spacer().frame(width: 15)
            Text(message)
                    .appFontBold(size: 14)
                    .foregroundColor(.white)
            Spacer()
        }
    }

}
