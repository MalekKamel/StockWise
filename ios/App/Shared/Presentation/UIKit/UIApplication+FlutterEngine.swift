//
// Created by Kamel on 09/09/2022.
// Copyright (c) 2022 sha. All rights reserved.
//

import UIKit
import Flutter

extension UIApplication {

    static var engine: FlutterEngine {
        appDelegate.engine
    }

    static var binaryMessenger: FlutterBinaryMessenger {
        engine.binaryMessenger
    }

}
