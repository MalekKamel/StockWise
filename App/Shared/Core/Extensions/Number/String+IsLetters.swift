//
// Created by Kamel on 01/03/2023.
//

import Foundation

public extension String {
    var isLetters: Bool {
        isEmpty || rangeOfCharacter(from: .letters) != nil
    }
}
