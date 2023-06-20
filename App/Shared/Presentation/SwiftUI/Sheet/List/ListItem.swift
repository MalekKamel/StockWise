//
// Created by Kamel on 04/03/2023.
//


import Foundation

public struct ListItem: Identifiable, Hashable {
    public var name: String
    public var id: String
    public var tag: Int
    public var filterNames: [String]

    public init(
            name: String,
            id: String,
            tag: Int = 0,
            filterNames: [String] = []) {
        self.name = name
        self.id = id
        self.tag = tag
        self.filterNames = filterNames.isEmpty ? [name] : filterNames
    }
}