//
// Created by Kamel on 04/09/2021.
// Copyright (c) 2021 sha. All rights reserved.
//

import Foundation
import Moya

public extension Swift.Error {

    var apiErrorMessage: String? {
        let moyaError = moyaError
        guard moyaError == nil else {
            return moyaError
        }

        return localizedDescription
    }

    var moyaError: String? {
        guard let error = self as? MoyaError else {
            return nil
        }
        guard let response = error.response else {
            return nil
        }
        let apiResponse = try? JSONDecoder().decode(ApiErrorResponse.self, from: response.data)
        return apiResponse?.message
    }
}

