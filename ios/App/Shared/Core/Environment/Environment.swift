//
// Created by Kamel on 09/07/2021.
// Copyright (c) 2021 sha. All rights reserved.
//

import Foundation

class AppEnvironment {
    static let shared = AppEnvironment()

    private init() {
    }

    lazy var baseUrl: String = AppPList.value(of: .baseUrl)
}