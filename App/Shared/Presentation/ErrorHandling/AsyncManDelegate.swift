//
// Created by Kamel on 23/06/2021.
//

import Foundation


/// This protocol is responsible for presenting UI
public protocol AsyncManDelegate {

    /// show loading indicator
    func showLoading()

    /// hide loading indicator
    func hideLoading()

    ///  show error string
    func show(error: String)

    /// called when no error handler can handle the exception
    func onHandleErrorFailed(error: Error)
}