//
// Created by Kamel on 23/06/2022.
// Copyright (c) 2022 sha. All rights reserved.
//

import Moya
import Foundation

typealias StockApiProvider = MoyaProvider<StockApi>

enum StockApi {
    case stocks
    case stockChartData(symbol: String, startTimestamp: String)
}

extension StockApi: MoyaTargetType {

    var baseURL: URL {
        switch self {
        case .stocks:
            return URL(string: "https://run.mocky.io/v3")!
        case .stockChartData(let symbol, _):
            return URL(string: "https://query2.finance.yahoo.com/v8/finance/chart")!
        }
    }

    public var path: String {
        switch self {
        case .stocks:
            return "2b63ba43-6440-4780-aa13-91e6d8247305"
        case .stockChartData(let symbol, _):
            return symbol.uppercased()
        }
    }

    public var method: Moya.Method {
        switch self {
        case .stocks,
             .stockChartData:
            return .get
        }
    }

    public var task: Task {
        switch self {
        case .stockChartData(_, let startTimestamp):
            let parameters: [String: Any] = [
                "period1": startTimestamp,
                "period2": "\(Int(Date().timeIntervalSince1970))",
                "interval": "1d",
                "includePrePost": "False",
                "events": "div,splits"
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .stocks:
            return .requestPlain
        }
    }
}