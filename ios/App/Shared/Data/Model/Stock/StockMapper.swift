//
// Created by Shaban on 22/06/2023.
//

import Foundation

struct StockMapper {

    static func fromStockResponse(_ items: [StockResponse]) -> [Stock] {
        items.map { element in
            fromStockResponse(element)
        }
    }

    static func fromStockResponse(_ item: StockResponse) -> Stock {
        Stock(
                symbol: item.symbol,
                companyName: item.companyName,
                avgPrice: item.avgPrice,
                quantity: item.quantity,
                ltp: item.ltp)
    }

    static func fromChartDataResponse(_ item: StockChartDataResponse) -> [StockChartData] {
        let result = item.chart.result
        let timestamps = result[0].timestamp ?? []
        let quote = result[0].indicators.quote?[0]
        let openValues = quote?.quoteOpen ?? []
        let highValues = quote?.high ?? []
        let lowValues = quote?.low ?? []
        let closeValues = quote?.close ?? []
        let volumeValues = quote?.volume ?? []
        let adjCloseValues = result[0].indicators.adjClose?[0].adjclose ?? []

        var items: [StockChartData] = []
        for i in 0..<timestamps.count {
            let entry = StockChartData(date: String(timestamps[i]),
                    open: openValues[i],
                    high: highValues[i],
                    low: lowValues[i],
                    close: closeValues[i],
                    volume: Int64(volumeValues[i]),
                    adjClose: adjCloseValues[i]
            )
            items.append(entry)
        }

        return items
    }
}