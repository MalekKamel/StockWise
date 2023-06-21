//
// Created by Kamel on 18/04/2023.
//

import UIKit

struct AppActivityViewController {

    static func show(activityItems: [Any]) {
        DispatchQueue.main.async {
            let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
            UIApplication.shared.topViewController()?.present(activityVC, animated: true, completion: nil)
        }
    }
}
