//
// Created by Kamel on 23/12/2022.
//

import Foundation

public enum BuildConfig {
    case debug
    case testing
    case staging
    case release

    public static let current: BuildConfig = {
        guard let rawValue = Bundle.main.infoDictionary?["BuildConfig"] as? String else {
            fatalError("No Configuration Found")
        }
        print("CURRENT CONFIG: \(rawValue.lowercased())")
        switch rawValue.lowercased() {
        case "debug":
            return .debug
        case "testing":
            return .testing
        case "staging":
            return .staging
        case "release":
            return .release
        default:
            return .release
        }
    }()

    public static var isDebug: Bool {
        current == .debug
    }

    public static var isNotDebug: Bool {
        !isDebug
    }

    public static var isTesting: Bool {
        current == .testing
    }

    public static var isNotTesting: Bool {
        !isTesting
    }

    public static var isStaging: Bool {
        current == .staging
    }

    public static var isNotStaging: Bool {
        !isStaging
    }

    public static var isRelease: Bool {
        current == .release
    }

    public static var isNotRelease: Bool {
        !isRelease
    }

}

