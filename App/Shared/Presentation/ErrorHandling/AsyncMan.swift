//
// Created by Kamel on 09/06/2022.
// Copyright (c) 2022 sha. All rights reserved.
//

import Foundation

public typealias AsyncOperation = () async throws -> Void
public typealias AsyncCompletion<T> = (T) -> Void

public protocol AsyncManContract {
    func request(
            _ operation: @escaping AsyncOperation,
            options: RequestOptions,
            delegate: AsyncManDelegate?
    )
}

public struct AsyncMan: AsyncManContract {
    /// Set NSError handlers
    public static var nsErrorHandlers: Array<NSErrorHandler> = []

    /// Set Error handlers
    public static var errorHandlers: Array<ErrorHandler> = [
        UnauthorizedErrorHandler()
    ]

    public init() {
    }

    public func requestAsync(
            _ operation: @escaping AsyncOperation,
            options: RequestOptions = RequestOptions.defaultOptions(),
            delegate: AsyncManDelegate? = nil
    ) async throws {
        if options.showLoading {
            delegate?.showLoading()
        }
         await doRequest(operation, options: options, delegate: delegate)
    }

    public func request(
            _ operation: @escaping AsyncOperation,
            options: RequestOptions = RequestOptions.defaultOptions(),
            delegate: AsyncManDelegate? = nil
    ) {
        if options.showLoading {
            delegate?.showLoading()
        }

        Task {
             await doRequest(operation, options: options, delegate: delegate)
        }
    }

    private func doRequest(
            _ operation: @escaping AsyncOperation,
            options: RequestOptions = RequestOptions.defaultOptions(),
            delegate: AsyncManDelegate? = nil
    ) async {
        let retry = {
            request(operation,
                    options: options,
                    delegate: delegate)
        }
        do {
            if !options.isOfflineSupported, AppNetworkManager.shared.isDisconnected {
                try await handle(error: AppError.connection, presentable: delegate, retry: retry)
                if options.hideLoading {
                    delegate?.hideLoading()
                }
                return
            }

            try await operation()
        } catch {
            await onError(error, options: options, delegate: delegate, retry: retry)
        }
        if options.hideLoading {
            delegate?.hideLoading()
        }
    }

    private func onError(
            _ error: Error,
            options: RequestOptions,
            delegate: AsyncManDelegate? = nil,
            retry: @escaping () -> Void
    ) async {
        options.doOnError?(error)

        if options.inlineHandling?(error) == true {
            return
        }
        do {
            try await handle(error: error, presentable: delegate, retry: retry)
        } catch {
            await onError(error, options: options, delegate: delegate, retry: retry)
        }
    }

    private func handle(
            error: Error,
            presentable: AsyncManDelegate?,
            retry: @escaping () -> Void) async throws {
        let args = ErrorProcessorArgs(asyncMan: self, retry: retry)
        try await ErrorProcessor.shared.process(error: error, delegate: presentable, args: args)
    }
}
