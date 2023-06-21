//
// Created by Kamel on 05/02/2023.
//

import Foundation

import SwiftUI

public class AppHostingController<Content> : UIHostingController<Content> where Content : View {
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
}
