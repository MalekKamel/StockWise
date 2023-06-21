//
// Created by Kamel on 18/05/2021.
// Copyright (c) 2021 sha. All rights reserved.
//

import Foundation
import Moya

protocol MoyaTargetType: TargetType {

}

extension MoyaTargetType {
    public var baseURL: URL {
        URL(string: AppEnvironment.shared.baseUrl)!
    }

    public var validationType: ValidationType {
        .none
    }

    public var sampleData: Data {
        Data()
    }

    public var headers: [String: String]? {
        [
            "Authorization": "Bearer \(AppUserDefaults.shared.accessToken ?? "")",
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Accept-Language": AppLanguage.current.rawValue,
        ]
    }

    var parameters: [String: Any]? {
        nil
    }

}
