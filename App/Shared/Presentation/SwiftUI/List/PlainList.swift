//
// Created by Kamel on 17/05/2022.
// Copyright (c) 2022 sha. All rights reserved.
//

import SwiftUI

public struct PlainList<Content: View, LastItem: View, Item: Identifiable>: View {
    private let items: [Item]
    private let content: (Item) -> Content
    private let cellBottomPadding: CGFloat
    private let rowColor: Color
    private let lastItem: LastItem

    public init(
            _ items: [Item],
            rowColor: Color = .white,
            cellBottomPadding: CGFloat = 10,
            lastItem: () -> LastItem,
            @ViewBuilder content: @escaping (Item) -> Content) {
        self.items = items
        self.cellBottomPadding = cellBottomPadding
        self.rowColor = rowColor
        self.lastItem = lastItem()
        self.content = content
        UICollectionView.appearance().backgroundColor = .clear
    }

    public var body: some View {
        Group {
            if items.isEmpty {
                InfiniteHeightSpacer()
            } else {
                ListContainer()
            }
        }
    }

    private func ListContainer() -> some View {
//        ListView()
        // TODO: implement later after fixing: closure containing control flow statement cannot be used with result builder CommandsBuilder
        Group {
            if #available(iOS 16.0, *) {
                ListView()
                        .scrollContentBackground(.hidden)
            } else {
                ListView()
            }
        }
    }

    private func ListView() -> some View {
        ScrollView(showsIndicators: false) {
            LazyVStack {
                ForEach(items) { item in
                    content(item)
                            .padding(.bottom, cellBottomPadding)
                            .removeListSeparator(color: rowColor)
                }

                lastItem
                        .padding(.bottom, cellBottomPadding)
                        .removeListSeparator(color: rowColor)
            }
                    .listStyle(.plain)
        }
    }
}

public extension PlainList where LastItem == EmptyView {

    init(
            _ items: [Item],
            rowColor: Color = .white,
            cellBottomPadding: CGFloat = 10,
            @ViewBuilder content: @escaping (Item) -> Content) {
        self.items = items
        self.cellBottomPadding = cellBottomPadding
        self.rowColor = rowColor
        lastItem = EmptyView()
        self.content = content
        UICollectionView.appearance().backgroundColor = .clear
    }

}

extension UICollectionReusableView {
    override open var backgroundColor: UIColor? {
        get {
            .clear
        }
        set {
        }

        // default separators use same color as background
        // so to have it same but new (say red) it can be
        // used as below, otherwise we just need custom separators
        //
        // set { super.backgroundColor = .red }
    }
}
