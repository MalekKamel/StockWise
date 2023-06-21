//
// Created by Kamel on 05/02/2023.
//

import Foundation

public func onMainThread(_ callback: @escaping () -> Void) {
    DispatchQueue.main.async(execute: callback)
}