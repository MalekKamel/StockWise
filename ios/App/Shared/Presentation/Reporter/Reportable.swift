//
// Created by Kamel on 25/06/2021.
//

import UIKit
import SwiftMessages

public protocol Reportable {

    func showSuccess(
            title: String?,
            message: String?,
            actionTitle: String?,
            iconImageView: UIImageView?,
            actionBlock: (() -> Void)?
    )

    func showError(
            title: String?,
            message: String?,
            actionTitle: String?,
            iconImageView: UIImageView?,
            actionBlock: (() -> Void)?
    )

    func show(error: Error, title: String)
    func show(error: String, title: String)
}

public extension Reportable {

    func showSuccess(
            title: String? = nil,
            message: String?,
            actionTitle: String? = nil,
            iconImageView: UIImageView? = nil,
            actionBlock: (() -> Void)? = nil
    ) {
        onMainThread {
            showSwiftMessage(
                    title: title,
                    message: message,
                    layout: .messageView,
                    theme: .success,
                    backgroundColor: .green,
                    iconImageView: iconImageView,
                    feedbackType: .success
            )
        }
    }

    func show(error: String, title: String = "") {
        onMainThread {
            showError(
                    title: title,
                    message: error
            )
        }
    }

    func show(error: Error, title: String = "") {
        onMainThread {
            show(error: error.localizedDescription, title: title)
        }
    }

    func showError(
            title: String? = nil,
            message: String?,
            actionTitle: String? = nil,
            iconImageView: UIImageView? = nil,
            actionBlock: (() -> Void)? = nil
    ) {
        let image = UIImage(systemName: .exclamationMarkCircleFill)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        let imageView = UIImageView(image: image)
        showSwiftMessage(
                title: title,
                message: message,
                actionTitle: actionTitle,
                actionBlock: actionBlock,
                layout: .messageView,
                theme: .error,
                iconImageView: imageView,
                feedbackType: .error
        )
    }

}

fileprivate func showSwiftMessage(
        title: String? = nil,
        message: String?,
        actionTitle: String? = nil,
        actionBlock: (() -> Void)? = nil,
        layout: MessageView.Layout,
        theme: Theme,
        backgroundColor: UIColor? = nil,
        iconImageView: UIImageView? = nil,
        feedbackType: UINotificationFeedbackGenerator.FeedbackType
) {
    guard let message, !message.isEmpty else {
        return
    }
    AppCrashlytics.record(description: title ?? "", failure: message)

    UINotificationFeedbackGenerator().notificationOccurred(feedbackType)

    var config = SwiftMessages.Config()

    config.duration = .seconds(seconds: 6)
    config.ignoreDuplicates = true
    config.dimMode = .gray(interactive: true)

    let type = MessageViewType.from(theme: theme)
    let messageView = AppMessageView(
            message: message,
            type: type)
    guard let v = AppHostingController(rootView: messageView).view else {
        return
    }
    v.backgroundColor = UIColor(type.color)
    SwiftMessages.show(config: config, view: v)
}