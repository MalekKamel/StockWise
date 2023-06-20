//
// Created by Kamel on 30/03/2023.
//

import Foundation

public extension Optional where Wrapped: Collection {

    var isEmptyOrNil: Bool {
        self?.isEmpty ?? true
    }

}