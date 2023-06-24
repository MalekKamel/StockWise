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
    let indicators: Indicators
    let timestamp: [Int]?

    enum CodingKeys: String, CodingKey {
        case indicators = "indicators"
        case timestamp = "timestamp"
    }
}

// MARK: - Indicators
struct Indicators: Codable {
    let quote: [Quote]?
    let adjClose: [Adjclose]?

    enum CodingKeys: String, CodingKey {
        case quote = "quote"
        case adjClose = "adjclose"
    }
}

// MARK: - Adjclose
struct Adjclose: Codable {
    let adjclose: [Double]?

    enum CodingKeys: String, CodingKey {
        case adjclose = "adjclose"
    }
}

// MARK: - Quote
struct Quote: Codable {
    let low: [Double]?
    let volume: [Int]?
    let high: [Double]?
    let close: [Double]?
    let quoteOpen: [Double]?

    enum CodingKeys: String, CodingKey {
        case low = "low"
        case volume = "volume"
        case high = "high"
        case close = "close"
        case quoteOpen = "open"
    }
}