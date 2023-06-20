//
// Created by Kamel on 22/02/2023.
//

import SwiftUI

public struct RootApp<V: View>: View {
    private let view: V
    @ObservedObject var vm: RootAppVM

    public init(view: V, vm: RootAppVM) {
        self.view = view
        self.vm = vm
    }

    public var body: some View {
        view
                .environment(\.layoutDirection, AppLanguage.layoutDirection)
                .environment(\.locale, AppLanguage.locale)
    }
}
