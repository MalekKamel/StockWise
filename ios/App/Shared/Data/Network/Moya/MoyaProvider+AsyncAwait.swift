//
// Created by Kamel on 19/06/2022.
// Copyright (c) 2022 sha. All rights reserved.
//

import Foundation
import Moya
import Combine

extension MoyaProvider {

    func request<T: Decodable>(
            target: Target,
            progress: ProgressBlock? = .none,
            arrayResponse: Bool = false
    ) async throws -> T {
        try await withCheckedThrowingContinuation { continuation in
            request(target, progress: progress) {
                switch $0 {
                case let .success(response):
                    do {
                        let filteredResponse = try response.filterSuccessfulStatusCodes()
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(T.self, from: filteredResponse.data)
                        continuation.resume(returning: result)
                    } catch {
                        NSLog("Error in read(from:ofType:) domain= \(error), description= \(error.localizedDescription)")
                        continuation.resume(throwing: error)
                    }
                case let .failure(error):
                    print("Request Error: \(error)")
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
