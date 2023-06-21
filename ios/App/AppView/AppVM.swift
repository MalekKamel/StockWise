//
// Created by Shaban on 21/06/2023.
//

import Foundation

class AppVM: AppViewModel {
    var requester: AsyncManContract

    init(requester: AsyncManContract = AsyncMan()) {
        self.requester = requester
    }

}