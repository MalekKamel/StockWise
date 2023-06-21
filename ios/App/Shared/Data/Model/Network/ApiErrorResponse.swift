//
// Created by Kamel on 16/02/2023.
//

import Foundation

public struct ApiErrorResponse: Codable {
    let message: String?

    enum CodingKeys: String, CodingKey {
        case message = "message"
    }
}

