//
// Created by Shaban on 23/06/2023.
//

import SwiftUI
import Flutter

struct FlutterView: UIViewControllerRepresentable {
    var engine: FlutterEngine = UIApplication.engine
    var initialRoute: String?

    func makeUIViewController(context: Context) -> FlutterViewController {
        let controller = FlutterViewController(engine: engine, nibName: nil, bundle: nil)
        if let initialRoute {
            controller.setInitialRoute(initialRoute)
        }
        return controller
    }

    func updateUIViewController(_ uiViewController: FlutterViewController, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator {

    }
}
