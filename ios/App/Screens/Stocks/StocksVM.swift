//
// Created by Kamel on 29/05/2023.
//

import Foundation
import Flutter

class StocksVM: AppViewModel {
    var requester: AsyncManContract
    let stocksApi: FlutterStocksApi

    @Published var count = 0

    init(stocksApi: FlutterStocksApi, requester: AsyncManContract = AsyncMan()) {
        self.requester = requester
        self.stocksApi = stocksApi
    }
}
