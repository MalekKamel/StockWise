//
// Created by Kamel on 03/01/2023.
//

import Foundation

public enum DefaultsKey {
    case accessToken

    public var name: String {
        get {
            "\(self)"
        }
    }
}

public protocol AppUserDefaultsContract {
    var accessToken: String? { get set }
}

public class AppUserDefaults: AppUserDefaultsContract {
    static let shared = AppUserDefaults()

    public var accessToken: String? {
        get {
            AppDefaults.value(for: .accessToken)
        }
        set {
            AppDefaults.save(value: newValue, key: .accessToken)
        }
    }
}
