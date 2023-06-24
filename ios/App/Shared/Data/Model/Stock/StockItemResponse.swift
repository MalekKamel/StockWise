//
// Created by Shaban on 24/06/2023.
//

import Foundation

struct StockResponse: Codable {
    let stocks: [StockItemResponse]

    enum CodingKeys: String, CodingKey {
        case stocks = "stocks"
    }
}

struct StockItemResponse: Codable {
    let symbol: String
    let companyName: String
    let avgPrice: Double
    let quantity: Double
    let ltp: Double

    enum CodingKeys: String, CodingKey {
        case symbol = "symbol"
        case companyName = "companyName"
        case avgPrice = "avgPrice"
        case quantity = "quantity"
        case ltp = "ltp"
    }
}
