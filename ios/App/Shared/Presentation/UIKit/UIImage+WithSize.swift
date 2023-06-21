//
// Created by Kamel on 09/11/2022.
// Copyright (c) 2022 sha. All rights reserved.
//

import UIKit

public extension UIImage {
    func witSize(_ newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        draw(in: CGRectMake(0, 0, newSize.width, newSize.height))
        let newImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? self
    }
}

