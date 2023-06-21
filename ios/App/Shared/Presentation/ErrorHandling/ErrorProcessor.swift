//
// Created by Kamel on 23/06/2021.
//

import Foundation

public struct ErrorProcessorArgs {
    let asyncMan: AsyncMan
    let retry: () -> Void
}

/// The class that processes the error and passes it to the correct handlers
public class ErrorProcessor {
    static let shared = ErrorProcessor()

    func process(error: Swift.Error, delegate: AsyncManDelegate?, args: ErrorProcessorArgs) async throws {
        if try await handleNSError(error: error as NSError, presentable: delegate, args: args) {
            return
        }

        if try await handle(error: error, delegate: delegate, args: args) {
            return
        }

        unknownError(error: error, delegate: delegate)
    }
}

private func handle(error: Swift.Error, delegate: AsyncManDelegate?, args: ErrorProcessorArgs) async throws -> Bool {
    let handler: ErrorHandler? = AsyncMan.errorHandlers.first(where: {
        $0.canHandle(error: error)
    })

    guard let handler else {
        return false
    }

    try await handler.handle(error: error, delegate: delegate, args: args)
    return true
}

private func handleNSError(error: NSError, presentable: AsyncManDelegate?, args: ErrorProcessorArgs) async throws -> Bool {
    let handler: NSErrorHandler? = AsyncMan.nsErrorHandlers.first(where: {
        $0.canHandle(error: error)
    })

    guard let handler else {
        return false
    }

    handler.handle(error: error, presentable: presentable)
    return true
}

private func unknownError(error: Swift.Error, delegate: AsyncManDelegate?) {
    onMainThread {
        delegate?.onHandleErrorFailed(error: error)
    }
}