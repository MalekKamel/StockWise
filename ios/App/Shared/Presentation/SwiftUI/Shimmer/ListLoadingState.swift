//
// Created by Kamel on 07/11/2022.
// Copyright (c) 2022 sha. All rights reserved.
//

import Combine
import SwiftUI

public enum ListLoadingState<Item: Identifiable> {
    case `default`
    case loading(placeholder: AnyView)
    case loaded(items: [Item])
    case empty

    public static func from<Item: Identifiable>(_ items: [Item]) -> ListLoadingState<Item> {
        guard !items.isEmpty else {
            return .empty
        }
        return .loaded(items: items)
    }

    var items: [Item] {
        switch self {
        case let .loaded(items):
            return items
        case .default,
             .loading,
             .empty:
            return []
        }
    }
}