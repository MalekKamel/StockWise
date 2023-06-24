//
// Created by Shaban on 22/06/2023.
//

import Foundation

enum DateFormat: String {
    case yyyyMMdd = "yyyy-MM-dd"
}

class AppDate {
    static func format(_ date: Date, dateFormat: DateFormat = .yyyyMMdd) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat.rawValue
        return formatter.string(from: date)
    }

    static func date(from string: String, withFormat format: DateFormat = .yyyyMMdd) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter.date(from: string) ?? Date()
    }
}