//
// Created by Kamel on 04/11/2022.
// Copyright (c) 2022 sha. All rights reserved.
//

import SwiftUI

public extension Shape {
    func fill<Fill: ShapeStyle, Stroke: ShapeStyle>(
            _ fillStyle: Fill,
            stroke: Stroke,
            style: StrokeStyle
    ) -> some View {
        self
                .stroke(stroke, style: style)
                .background(self.fill(fillStyle))
    }
}

