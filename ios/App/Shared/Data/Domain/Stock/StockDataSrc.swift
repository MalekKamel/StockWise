//
// Created by Kamel on 09/06/2022.
// Copyright (c) 2022 sha. All rights reserved.
//

import Foundation

protocol StockDataSrcContract {
}

struct StockDataSrc: StockDataSrcContract {
    private let api: StockApiProvider

    init(api: StockApiProvider) {
        self.api = api
    }
}
