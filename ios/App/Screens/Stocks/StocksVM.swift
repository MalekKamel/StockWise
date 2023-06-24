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
    @Published var stockChartData: [StockChartData] = []
    @Published var stocks: [Stock] = []

    init(stocksApi: FlutterStocksApi,
         requester: AsyncManContract = AsyncMan(),
         stockRepo: StockRepoContract = StockRepo.build()) {
        self.requester = requester
        self.stocksApi = stocksApi
        self.stockRepo = stockRepo
        HostStocksApiSetup.setUp(binaryMessenger: UIApplication.binaryMessenger, api: self)
    }

}

extension StocksVM: HostStocksApi {

    func loadStockChart(symbol: String, date: String, completion: @escaping (Result<[StockChartData], Error>) -> Void) {
        request { [weak self] in
            guard let self else {
                return
            }
            let response = try await self.stockRepo.loadStockChartData(ticker: symbol, date: AppDate.date(from: date))
            onMainThread {
                self.stockChartData = response
                completion(Result.success(response))
            }
        }
    }

    func loadStocks(completion: @escaping (Result<[Stock], Error>) -> Void) {
        request { [weak self] in
            guard let self else {
                return
            }
            let response = try await self.stockRepo.loadStocks()
            onMainThread {
                self.stocks = StockMapper.fromStockResponse(response.stocks)
                completion(Result.success(self.stocks))
            }
        }
    }
}
