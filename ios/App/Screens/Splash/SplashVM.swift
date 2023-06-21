//
// Created by Kamel on 29/05/2023.
//

import Foundation
import Flutter

class SplashVM: AppViewModel {
    var requester: AsyncManContract

    var methodChannel: FlutterMethodChannel?
    @Published var count = 0

    init(requester: AsyncManContract = AsyncMan()) {
        self.requester = requester
    }
}
