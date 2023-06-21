//
// Created by Kamel on 02/11/2022.
// Copyright (c) 2022 sha. All rights reserved.
//

import SwiftUI

public struct PagedList<Content: View, EmptyContent: View, Item: Identifiable>: View {
    private let items: ListLoadingState<Item>
    private let content: (Item) -> Content
    private let cellBottomPadding: CGFloat
    private let rowColor: Color
    private let hasMoreItems: Bool
    private let emptyContent: EmptyContent
    private let loadMore: () -> Void

    public init(
            _ items: ListLoadingState<Item>,
            hasMoreItems: Bool,
            loadMore: @escaping () -> Void,
            rowColor: Color = .white,
            cellBottomPadding: CGFloat = 10,
            emptyContent: () -> EmptyContent,
            @ViewBuilder content: @escaping (Item) -> Content) {
        self.items = items
        self.hasMoreItems = hasMoreItems
        self.loadMore = loadMore
        self.cellBottomPadding = cellBottomPadding
        self.rowColor = rowColor
        self.emptyContent = emptyContent()
        self.content = content
    }

    public var body: some View {
        LoadingList(
                items,
                rowColor: rowColor,
                cellBottomPadding: cellBottomPadding,
                emptyContent: { emptyContent },
                lastItem: {
                    LastItemView()
                },
                content: content)
    }

    private func LastItemView() -> some View {
        Group {
            if hasMoreItems, AppNetworkManager.shared.isConnected {
                HStack {
                    InfiniteWidthSpacer()
                    Spinner(style: .medium, deadline: .now() + 2)
                            .onAppear {
                                loadMore()
                            }
                    InfiniteWidthSpacer()
                }
            }
        }
    }

}

