//
// Created by Kamel on 29/05/2023.
//

import UIKit
import SwiftUI
import Flutter
import FlutterPluginRegistrant

@UIApplicationMain
class AppDelegate: FlutterAppDelegate, ObservableObject {
    lazy var engine: FlutterEngine = FlutterEngine.init(name: "ios.flutter")

    override func application(
            _ application: UIApplication,
            didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Runs the default Dart entrypoint with a default Flutter route.
        engine.run()

        // Connects plugins with iOS platform code to this app.
        GeneratedPluginRegistrant.register(with: engine)

        AppKeyboardManager.setup()

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    override func application(
            _ application: UIApplication,
            configurationForConnecting connectingSceneSession: UISceneSession,
            options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

}