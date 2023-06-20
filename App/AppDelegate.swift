//
// Created by Kamel on 29/05/2023.
//

import UIKit
import SwiftUI


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ObservableObject {
    var window: UIWindow?

    func application(
            _ application: UIApplication,
            didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        AppKeyboardManager.setup()

        return true
    }

    func application(
            _ application: UIApplication,
            configurationForConnecting connectingSceneSession: UISceneSession,
            options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

}