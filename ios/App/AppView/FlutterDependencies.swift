//
// Created by Shaban on 21/06/2023.
//

import SwiftUI
import Flutter
// The following library connects plugins with iOS platform code to this app.
import FlutterPluginRegistrant

class FlutterDependencies: ObservableObject {
    let flutterEngine = FlutterEngine(name: "my flutter engine")
    init(){
        // Runs the default Dart entrypoint with a default Flutter route.
        flutterEngine.run()
        // Connects plugins with iOS platform code to this app.
        GeneratedPluginRegistrant.register(with: self.flutterEngine);
    }
}
