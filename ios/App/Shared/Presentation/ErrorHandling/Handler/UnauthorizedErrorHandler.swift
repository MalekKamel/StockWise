//
// Created by Kamel on 15/03/2023.
//

import Moya

struct UnauthorizedErrorHandler: ErrorHandler {

    func canHandle(error: Error) -> Bool {
        guard let error = error as? MoyaError else {
            return false
        }
        switch error {
        case .statusCode(let response):
            return response.statusCode == 403
        default: return false
        }
    }

    func handle(error: Error, delegate: AsyncManDelegate?, args: ErrorProcessorArgs) async throws {

    }

}

