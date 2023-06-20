//
// Created by Kamel on 23/06/2022.
// Copyright (c) 2022 sha. All rights reserved.
//

import Moya
import Foundation

typealias StockApiProvider = MoyaProvider<StockApi>

enum StockApi {
    case example
}

extension StockApi: MoyaTargetType {

    public var path: String {
        switch self {
        case .example:
            return ""
        }
    }

    public var method: Moya.Method {
        switch self {
        case .example:
            return .get
        }
    }

    public var task: Task {
        switch self {
        case .example:
            return .requestPlain
        }
    }
}