//
// Created by Kamel on 16/04/2023.
//

import Foundation
import Kingfisher

struct AppKingFisher {

    static func retrieveImage(
            url: URL,
            completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)?) {
        KingfisherManager.shared.retrieveImage(
                with: .network(ImageResource(downloadURL: url)),
                completionHandler: completionHandler)
    }
}
