//
// Created by Kamel on 25/02/2023.
//

import SwiftUI

struct AppActionSheet {

    static func create(
            items: [String],
            title: Text,
            onItemSelected: @escaping (Int, String) -> Void
    ) -> ActionSheet {
        var buttons: [ActionSheet.Button] = items.enumerated().map { index, element in
            .default(Text(element).appFont(size: 14)) {
                onItemSelected(index, element)
            }
        }
        buttons.append(.cancel())
        return ActionSheet(
                title: title,
                buttons: buttons
        )
    }
}
