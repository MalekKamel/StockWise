//
// Created by Kamel on 04/06/2023.
//

import SwiftUI

struct ConfirmAlert {

    static func create(
            title: String,
            message: String,
            action: @escaping (Bool) -> Void) -> Alert {
        Alert(
                title: Text(title),
                message: Text(message),
                primaryButton: .default(
                        Text(Strings.confirm),
                        action: {
                            action(true)
                        }
                ),
                secondaryButton: .cancel(
                        Text(Strings.cancel),
                        action: {
                            action(false)
                        }
                )
        )
    }

}
