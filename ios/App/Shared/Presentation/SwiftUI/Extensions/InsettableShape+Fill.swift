//
// Created by Kamel on 04/11/2022.
// Copyright (c) 2022 sha. All rights reserved.
//

import SwiftUI

public extension InsettableShape {
    func fill<Fill: ShapeStyle, Stroke: ShapeStyle>(
            _ fillStyle: Fill,
            strokeBorder strokeStyle: Stroke,
            lineWidth: Double = 1) -> some View {
        self
                .strokeBorder(strokeStyle, lineWidth: lineWidth)
                .background(self.fill(fillStyle))
    }
}

