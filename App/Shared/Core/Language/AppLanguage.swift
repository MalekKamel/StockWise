//
// Created by Kamel on 19/12/2022.

import SwiftUI

public enum AppLanguage: String {
    case en = "en"

    public static var locale: Locale {
        .init(identifier: AppLanguage.current.rawValue)
    }

    public static var layoutDirection: LayoutDirection {
        .leftToRight
    }

    public var bundle: Bundle {
        guard let path = Bundle.main.path(forResource: self.rawValue, ofType: "lproj") else {
            return .main
        }
        return Bundle(path: path) ?? .main
    }

    public static var current: AppLanguage {
        .en
    }

    public static func from(_ value: String) -> AppLanguage {
        AppLanguage(rawValue: value) ?? .current
    }
}

public extension Locale {
    static func preferredLocale() -> Locale {
        guard let preferredIdentifier = Locale.preferredLanguages.first else {
            return Locale.current
        }
        return Locale(identifier: preferredIdentifier)
    }
}
