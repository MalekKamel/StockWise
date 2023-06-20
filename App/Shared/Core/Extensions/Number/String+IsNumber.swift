//
// Created by Kamel on 01/03/2023.
//

import Foundation

import Foundation

public extension String {
    var isNumber: Bool {
        !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}