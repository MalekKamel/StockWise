//
// Created by Kamel on 05/01/2023.
// Copyright (c) 2023 sha. All rights reserved.
//

import SwiftUI
import SwiftMessages

public enum MessageViewType {
    case success
    case error

    public var color: Color {
        switch self {
        case .success:
            return .green
        case .error:
            return .red
        }
    }

    public static func from(theme: Theme) -> MessageViewType {
        switch theme {
        case .success,
             .info:
            return .success
        case .error,
             .warning:
            return .error
        }
    }
}
