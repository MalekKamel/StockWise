//
// Created by Kamel on 07/11/2022.
// Copyright (c) 2022 sha. All rights reserved.
//

import SwiftUI

public struct ListPlaceholderView: View {
    let items: [PlaceholderItem] = PlaceholderItem.placeholders
    @Environment(\.redactionReasons) private var redactionReasons
    private var isRedacted: Bool {
        redactionReasons.contains(.placeholder)
    }

    public init() {
    }

    public var body: some View {
        PlainList(items) { item in
            VStack(alignment: .leading, spacing: 12) {
                Text(item.title)
                        .font(.title)
                Text(item.subtitle)
                        .font(.subheadline)
                Text(item.subtitle)
                        .font(.subheadline)
            }
                    .padding()
        }
    }
}

extension ListPlaceholderView {
    static func create() -> AnyView {
        ListPlaceholderView().eraseToAnyView()
    }
}

struct PlaceholderItem: Codable, Identifiable {
    var id: Int
    var title: String
    var subtitle: String
    var imageName: String
    static let placeholders: [Self] = (0..<10).map {
        .init(
                id: $0,
                title: "Lorem ipsum dolor",
                subtitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua., sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                imageName: "star.fill"
        )
    }
}
