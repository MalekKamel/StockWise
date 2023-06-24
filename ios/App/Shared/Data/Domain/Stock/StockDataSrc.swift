//
// Created by Kamel on 09/06/2022.
// Copyright (c) 2022 sha. All rights reserved.
//

import Foundation

protocol StockDataSrcContract {
    func loadStockChartData(ticker: String, date: Date) async throws -> [Stock]
}

struct StockDataSrc: StockDataSrcContract {
    private let api: StockApiProvider

    init(api: StockApiProvider) {
        self.api = api
    }

    func loadStockChartData(ticker: String, date: Date) async throws -> [Stock] {
        let response: StockChartDataResponse = try await api.request(
                target: .stockChartData(symbol: ticker, startTimestamp: String(Int(date.timeIntervalSince1970)))
        )
        return StockMapper.fromChartDataResponse(response)
    }
}
