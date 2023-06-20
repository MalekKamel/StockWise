//
// Created by Kamel on 09/06/2022.
// Copyright (c) 2022 sha. All rights reserved.
//

import Alamofire

public enum NetworkState {
    case connected
    case disconnected
}

public struct AppNetworkManager {
    public static let shared = AppNetworkManager()

    public var state: NetworkState {
        isConnected ? .connected : .disconnected
    }

    public var isDisconnected: Bool {
        !isConnected
    }

    public var isConnected: Bool {
        NetworkReachabilityManager(host: "www.google.com")?.isReachable ?? false
    }

    public static var isCellular: Bool {
        NetworkReachabilityManager(host: "www.google.com")?.isReachableOnCellular ?? false
    }

}
