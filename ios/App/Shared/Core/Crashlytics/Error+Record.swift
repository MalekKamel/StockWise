//
// Created by Kamel on 16/03/2023.
//

import Foundation

public extension Error {
    func record() {
        AppCrashlytics.record(error: self)
    }
}
