//
//  MockDataPreviews.swift
//
//  Created by Kamel on 07/02/2023.
//

import Foundation


class Fake {
    static let shared = Fake()

    lazy var listItems: [ListItem] =
            [
                ListItem(name: "Name", id: ""),
                ListItem(name: "Name", id: ""),
                ListItem(name: "Name", id: ""),
                ListItem(name: "Name", id: ""),
                ListItem(name: "Name", id: ""),
                ListItem(name: "Name", id: ""),
                ListItem(name: "Name", id: ""),
                ListItem(name: "Name", id: ""),
                ListItem(name: "Name", id: ""),
                ListItem(name: "Name", id: "")
            ]
}
