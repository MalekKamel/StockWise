//
// Created by Kamel on 29/05/2023.
//

import UIKit
import Flutter


class StocksVM: AppViewModel {
    var requester: AsyncManContract
    let stocksApi: FlutterStocksApi
    let stockRepo: StockRepoContract
    @Published var count = 0
    @Published var stocks: [Stock] = []

    init(stocksApi: FlutterStocksApi,
         requester: AsyncManContract = AsyncMan(),
         stockRepo: StockRepoContract = StockRepo.build()) {
        self.requester = requester
        self.stocksApi = stocksApi
        self.stockRepo = stockRepo
        HostStocksApiSetup.setUp(binaryMessenger: UIApplication.binaryMessenger, api: self)
    }

    func loadStockChartData(ticker: String, date: Date) {
        request { [weak self] in
            guard let self else {
                return
            }
            let response = try await self.stockRepo.loadStockChartData(ticker: ticker, date: date)
            onMainThread {
                self.stocks = response
                self.stocksApi.showStock(stocks: response) {
                }
            }
        }
    }

}

extension StocksVM: HostStocksApi {

    func loadStocks(symbol: String, date: String) throws {
        loadStockChartData(ticker: symbol, date: AppDate.date(from: date))
    }
}
