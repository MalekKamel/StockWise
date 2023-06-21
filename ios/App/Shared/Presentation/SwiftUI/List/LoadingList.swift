//
// Created by Kamel on 17/05/2022.
// Copyright (c) 2022 sha. All rights reserved.
//

import SwiftUI

public struct LoadingList<Content: View,
                         LastItem: View,
                         EmptyContent: View,
                         Item: Identifiable>: View {
    private let items: ListLoadingState<Item>
    private let content: (Item) -> Content
    private let cellBottomPadding: CGFloat
    private let rowColor: Color
    private let lastItem: LastItem
    private let emptyContent: EmptyContent

    private let fade = AnyTransition.opacity.animation(Animation.linear(duration: 0.5))

    public init(
            _ items: ListLoadingState<Item>,
            rowColor: Color = .white,
            cellBottomPadding: CGFloat = 10,
            emptyContent: () -> EmptyContent,
            lastItem: () -> LastItem,
            @ViewBuilder content: @escaping (Item) -> Content) {
        self.items = items
        self.cellBottomPadding = cellBottomPadding
        self.rowColor = rowColor
        self.emptyContent = emptyContent()
        self.lastItem = lastItem()
        self.content = content
        UICollectionView.appearance().backgroundColor = .clear
    }

    public var body: some View {
        Group {
            switch items {
            case .default:
                Shimmer(view: ListPlaceholderView.create())
            case .loading(let placeholder):
                Shimmer(view: placeholder)

            case .loaded(let items):
                PlainList(items,
                        rowColor: rowColor,
                        cellBottomPadding: cellBottomPadding,
                        lastItem: { lastItem },
                        content: content)
            case .empty:
                emptyContent
            }
        }
    }

    private func Shimmer(view: AnyView) -> some View {
        view
                .redacted(reason: .placeholder)
                .shimmer()
                .disabled(true)
                .transition(fade)
    }

}

public extension LoadingList where LastItem == EmptyView {

    init(
            _ items: ListLoadingState<Item>,
            rowColor: Color = .white,
            cellBottomPadding: CGFloat = 10,
            emptyContent: () -> EmptyContent,
            @ViewBuilder content: @escaping (Item) -> Content) {
        self.items = items
        self.cellBottomPadding = cellBottomPadding
        self.rowColor = rowColor
        lastItem = EmptyView()
        self.emptyContent = emptyContent()
        self.content = content
    }

}

public extension LoadingList where EmptyContent == EmptyView {

    init(
            _ items: ListLoadingState<Item>,
            rowColor: Color = .white,
            cellBottomPadding: CGFloat = 10,
            lastItem: () -> LastItem,
            @ViewBuilder content: @escaping (Item) -> Content) {
        self.items = items
        self.cellBottomPadding = cellBottomPadding
        self.rowColor = rowColor
        self.lastItem = lastItem()
        emptyContent = EmptyView()
        self.content = content
    }

}

public extension LoadingList where LastItem == EmptyView, EmptyContent == EmptyView {

    init(
            _ items: ListLoadingState<Item>,
            rowColor: Color = .white,
            cellBottomPadding: CGFloat = 10,
            @ViewBuilder content: @escaping (Item) -> Content) {
        self.items = items
        self.cellBottomPadding = cellBottomPadding
        self.rowColor = rowColor
        lastItem = EmptyView()
        emptyContent = EmptyView()
        self.content = content
    }

}