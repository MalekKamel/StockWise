//
// Created by Kamel on 28/03/2023.
//

import SwiftUI
import Kingfisher

public typealias AppRemoteImage = KFImage

public struct AppImage: View {
    let url: String

    public init(_ url: String) {
        self.url = url
    }

    public var body: some View {
        AppRemoteImage.url(URL(string: url))
                .resizable()
                .placeholder {
                    ProgressView()
                            .progressViewStyle(.circular)
                }
    }
}

extension AppRemoteImage {

    init(url: String?) {
        self.init(URL(string: url ?? ""))
    }
}
