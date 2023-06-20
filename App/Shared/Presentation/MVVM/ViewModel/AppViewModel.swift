//
// Created by Kamel on 04/04/2021.
//

import SwiftUI
import Combine

protocol AppViewModel: ObservableObject, AsyncManDelegate {
    var requester: AsyncManContract { get set }

    func request(
            inlineHandling: ((Error) -> Bool)?,
            doOnError: ((Error) -> Void)?,
            showLoading: Bool,
            hideLoading: Bool,
            _ operation: @escaping AsyncOperation
    )
}

extension AppViewModel {
    var requester: AsyncManContract {
        AsyncMan()
    }
}

extension AppViewModel {

    func showLoading() {
        onMainThread {
            AppActivityIndicator.show()
        }
    }

    func hideLoading() {
        onMainThread {
            AppActivityIndicator.hide()
        }
    }

    func show(error: String) {
        Reporter.shared.show(error: error)
    }

    func onHandleErrorFailed(error: Error) {
        Reporter.shared.show(error: error.underlyingErrorDescription)
    }
}

extension AppViewModel {

    func request(
            inlineHandling: ((Error) -> Bool)? = nil,
            doOnError: ((Error) -> Void)? = nil,
            showLoading: Bool = true,
            hideLoading: Bool = true,
            _ operation: @escaping AsyncOperation
    ) {
        let options = RequestOptions.Builder()
                .inlineErrorHandling(inlineHandling)
                .doOnError(doOnError)
                .showLoading(showLoading)
                .hideLoading(hideLoading)
                .build()
        requester.request(
                operation,
                options: options,
                delegate: self)
    }
}
