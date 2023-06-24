//
// Created by Kamel on 09/06/2022.
// Copyright (c) 2022 sha. All rights reserved.
//

import Foundation

protocol StockRepoContract {
    func loadStockChartData(ticker: String, date: Date) async throws -> [StockChartData]
    func loadStocks() async throws -> StockResponse
}

struct StockRepo: StockRepoContract {
    static let shared = StockRepo.build()
    private let src: StockDataSrcContract

    init(src: StockDataSrcContract) {
        self.src = src
    }

    func loadStockChartData(ticker: String, date: Date) async throws -> [StockChartData] {
        try await src.loadStockChartData(ticker: ticker, date: date)
    }

    func loadStocks() async throws -> StockResponse {
        try await src.loadStocks()
    }

}

extension StockRepo {

    static func build() -> StockRepo {
        let src = StockDataSrc(api: StockApiProvider.create())
        return StockRepo(src: src)
    }
}
