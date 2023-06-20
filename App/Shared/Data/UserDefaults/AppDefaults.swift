//
// Created by Kamel on 30/03/2023.
//

import Foundation

public struct AppDefaults {

    public static func save<T: Codable>(
            value: T,
            keyEncoded: DefaultsKey,
            _ defaults: UserDefaults = UserDefaults.standard
    ) {
        save(value: try? PropertyListEncoder().encode(value), key: keyEncoded)
    }

    public static func value<T: Decodable>(
            forEncoded key: DefaultsKey,
            _ defaults: UserDefaults = UserDefaults.standard
    ) -> T? {

        guard let data: Data = defaults.value(forKey: key.name) as? Data else {
            return nil
        }

        return try? PropertyListDecoder().decode(T.self, from: data) as T
    }

    public static func saveArray<T: Codable>(
            value: [T],
            keyEncoded: DefaultsKey,
            _ defaults: UserDefaults = UserDefaults.standard
    ) {
        save(value: try? PropertyListEncoder().encode(value), key: keyEncoded)
    }

    public static func valueArray<T: Decodable>(
            forEncoded key: DefaultsKey,
            _ defaults: UserDefaults = UserDefaults.standard
    ) -> [T]? {

        guard let data: Data = defaults.value(forKey: key.name) as? Data else {
            return nil
        }

        return try? PropertyListDecoder().decode([T].self, from: data) as [T]
    }

    public static func save(
            value: Any?,
            key: DefaultsKey,
            _ defaults: UserDefaults = UserDefaults.standard
    ) {
        defaults.setValue(value, forKey: key.name)
        defaults.synchronize()
    }

    public static func value<T>(
            for key: DefaultsKey,
            _ defaults: UserDefaults = UserDefaults.standard
    ) -> T? {
        defaults.value(forKey: key.name) as? T
    }

    public static func clearValue(
            for key: DefaultsKey,
            _ defaults: UserDefaults = UserDefaults.standard
    ) {
        defaults.setValue(nil, forKey: key.name)
        defaults.synchronize()
    }

    public static func clear(_ defaults: UserDefaults = UserDefaults.standard) {
        guard let domain = Bundle.main.bundleIdentifier else {
            return
        }
        defaults.removePersistentDomain(forName: domain)
        defaults.synchronize()
        print(Array(defaults.dictionaryRepresentation().keys).count)
    }
}
