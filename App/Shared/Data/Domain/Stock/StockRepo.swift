//
// Created by Kamel on 09/06/2022.
// Copyright (c) 2022 sha. All rights reserved.
//

import Foundation

protocol StockRepoContract {
}

struct StockRepo: StockRepoContract {
    static let shared = StockRepo.build()
    private let src: StockDataSrcContract

    init(src: StockDataSrcContract) {
        self.src = src
    }

}

extension StockRepo {

    static func build() -> StockRepo {
        let src = StockDataSrc(api: StockApiProvider.create())
        return StockRepo(src: src)
    }
}
