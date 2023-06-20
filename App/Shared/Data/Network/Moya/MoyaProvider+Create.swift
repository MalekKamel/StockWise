//
// Created by Kamel on 18/05/2021.
// Copyright (c) 2021 sha. All rights reserved.
//

import Foundation
import Moya
import Alamofire

extension MoyaProvider {

    static func create<Target: TargetType>() -> MoyaProvider<Target> {
        var config = NetworkLoggerPlugin.Configuration()

        let options: NetworkLoggerPlugin.Configuration.LogOptions = [
            .requestMethod,
            .requestHeaders,
            .requestBody,
            .successResponseBody,
            .errorResponseBody,
            .formatRequestAscURL]
        config.logOptions = options

        config.formatter = NetworkLoggerPlugin.Configuration.Formatter(responseData: jsonResponseDataFormatter)
        let logger = NetworkLoggerPlugin(configuration: config)

        return MoyaProvider<Target>(session: DefaultAlamofireSession.shared, plugins: [logger])
    }

    private static func jsonResponseDataFormatter(_ data: Data) -> String {
        do {
            let dataAsJSON = try JSONSerialization.jsonObject(with: data)
            let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
            return String(decoding: prettyData, as: UTF8.self)
        } catch {
            return String(decoding: data, as: UTF8.self)
        }
    }
}


class DefaultAlamofireSession: Alamofire.Session {
    static let shared: DefaultAlamofireSession = {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        let timeout: Double = 5 * 60
        configuration.timeoutIntervalForRequest = timeout
        configuration.timeoutIntervalForResource = timeout
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return DefaultAlamofireSession(configuration: configuration)
    }()
}
