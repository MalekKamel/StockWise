//
// Created by Kamel on 31/05/2023.
//

import XCTest
@testable import App

class AsyncManMock: AsyncManContract {
    var requestCalled = false
    var lastOperation: AsyncOperation?
    var lastOptions: RequestOptions?
    var lastDelegate: AsyncManDelegate?

    func request(
            _ operation: @escaping AsyncOperation,
            options: RequestOptions,
            delegate: AsyncManDelegate?
    ) {
        Task {
            try await operation()
        }
        requestCalled = true
        lastOperation = operation
        lastOptions = options
        lastDelegate = delegate
    }
}