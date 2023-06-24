//
// Created by Shaban on 22/06/2023.
//

import Foundation

struct StockChartDataResponse: Codable {
    let chart: Chart

    enum CodingKeys: String, CodingKey {
        case chart = "chart"
    }
}

// MARK: - Chart
struct Chart: Codable {
    let result: [ChartDataResult]

    enum CodingKeys: String, CodingKey {
        case result = "result"
    }
}

// MARK: - ChartDataResult
struct ChartDataResult: Codable {
    let meta: Meta
    let indicators: Indicators
    let timestamp: [Int]

    enum CodingKeys: String, CodingKey {
        case meta = "meta"
        case indicators = "indicators"
        case timestamp = "timestamp"
    }
}

// MARK: - Indicators
struct Indicators: Codable {
    let quote: [Quote]
    let adjClose: [Adjclose]

    enum CodingKeys: String, CodingKey {
        case quote = "quote"
        case adjClose = "adjclose"
    }
}

// MARK: - Adjclose
struct Adjclose: Codable {
    let adjclose: [Double]

    enum CodingKeys: String, CodingKey {
        case adjclose = "adjclose"
    }
}

// MARK: - Quote
struct Quote: Codable {
    let low: [Double]
    let volume: [Int]
    let high: [Double]
    let close: [Double]
    let quoteOpen: [Double]

    enum CodingKeys: String, CodingKey {
        case low = "low"
        case volume = "volume"
        case high = "high"
        case close = "close"
        case quoteOpen = "open"
    }
}

// MARK: - Meta
struct Meta: Codable {
    let chartPreviousClose: Double
    let validRanges: [String]
    let exchangeTimezoneName: String
    let symbol: String
    let dataGranularity: String
    let regularMarketTime: Int
    let regularMarketPrice: Double
    let exchangeName: String
    let instrumentType: String
    let gmtoffset: Int
    let priceHint: Int
    let timezone: String
    let firstTradeDate: Int
    let currency: String
    let currentTradingPeriod: CurrentTradingPeriod
    let range: String

    enum CodingKeys: String, CodingKey {
        case chartPreviousClose = "chartPreviousClose"
        case validRanges = "validRanges"
        case exchangeTimezoneName = "exchangeTimezoneName"
        case symbol = "symbol"
        case dataGranularity = "dataGranularity"
        case regularMarketTime = "regularMarketTime"
        case regularMarketPrice = "regularMarketPrice"
        case exchangeName = "exchangeName"
        case instrumentType = "instrumentType"
        case gmtoffset = "gmtoffset"
        case priceHint = "priceHint"
        case timezone = "timezone"
        case firstTradeDate = "firstTradeDate"
        case currency = "currency"
        case currentTradingPeriod = "currentTradingPeriod"
        case range = "range"
    }
}

// MARK: - CurrentTradingPeriod
struct CurrentTradingPeriod: Codable {
    let pre: Post
    let regular: Post
    let post: Post

    enum CodingKeys: String, CodingKey {
        case pre = "pre"
        case regular = "regular"
        case post = "post"
    }
}

// MARK: - Post
struct Post: Codable {
    let gmtoffset: Int
    let timezone: String
    let end: Int
    let start: Int

    enum CodingKeys: String, CodingKey {
        case gmtoffset = "gmtoffset"
        case timezone = "timezone"
        case end = "end"
        case start = "start"
    }
}