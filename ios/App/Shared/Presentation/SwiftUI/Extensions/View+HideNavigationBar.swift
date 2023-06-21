//
// Created by Kamel on 19/05/2021.
// Copyright (c) 2021 sha. All rights reserved.
//

import SwiftUI

public extension View {
    func hideNavigationBar(_ value: Bool) -> some View {
        Group {
            if !value {
                self
            } else {
                self.navigationBarTitle("", displayMode: .inline)
                        .navigationBarHidden(true)
                        .eraseToAnyView()
            }
        }
    }
}
