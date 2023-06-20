//
// Created by Kamel on 16/02/2023.
//

import Foundation

public struct AppPList {
    public static func value(
            of key: BuildConfigName,
            bundle: Bundle = Bundle.main
    ) -> String {
        bundle.infoDictionary?[key.rawValue] as? String ?? ""
    }
}

