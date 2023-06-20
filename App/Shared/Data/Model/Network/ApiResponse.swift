//
// Created by Kamel on 25/02/2023.
//

import Foundation

public struct ApiResponse<T: Codable>: Codable {
    public let results: T
    public let status: Int?
    public let success: Bool?

    enum CodingKeys: String, CodingKey {
        case results = "results"
        case status = "status"
        case success = "success"
    }
}

public struct OptionalApiResponse<T: Codable>: Codable {
    public let results: T?
    public let status: Int?
    public let success: Bool?

    enum CodingKeys: String, CodingKey {
        case results = "results"
        case status = "status"
        case success = "success"
    }
}


