import SwiftUI

final class KeyboardGuardian: ObservableObject {
    static let shared = KeyboardGuardian()

    private var notificationCenter: NotificationCenter

    @Published private(set) var currentHeight: CGFloat = 0
    @Published private(set) var isShown: Bool = false

    init(center: NotificationCenter = .default) {
        notificationCenter = center

        notificationCenter.addObserver(
                self,
                selector: #selector(keyBoardWillShow(notification:)),
                name: UIResponder.keyboardWillShowNotification,
                object: nil
        )

        notificationCenter.addObserver(
                self,
                selector: #selector(keyBoardWillHide(notification:)),
                name: UIResponder.keyboardWillHideNotification,
                object: nil
        )
    }

    deinit {
        notificationCenter.removeObserver(self)
    }

    @objc func keyBoardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            currentHeight = keyboardSize.height
            isShown = true
        }
    }

    @objc func keyBoardWillHide(notification: Notification) {
        currentHeight = 0
        isShown = false
    }
}
