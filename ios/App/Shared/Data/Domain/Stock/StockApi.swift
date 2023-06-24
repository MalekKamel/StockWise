//
// Created by Kamel on 23/06/2022.
// Copyright (c) 2022 sha. All rights reserved.
//

import Moya
import Foundation

typealias StockApiProvider = MoyaProvider<StockApi>

enum StockApi {
    case stockChartData(symbol: String, startTimestamp: String)
}

extension StockApi: MoyaTargetType {

    var baseURL: URL {
        URL(string: "https://query2.finance.yahoo.com/v8/finance/chart")!
    }

    public var path: String {
        switch self {
        case .stockChartData(let symbol,  _):
            return symbol.uppercased()
        }
    }

    public var method: Moya.Method {
        switch self {
        case .stockChartData:
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
        }
    }
}