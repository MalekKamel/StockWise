//
// Created by Kamel on 29/05/2023.
//

import SwiftUI
import SwiftUINavigator

struct AppView: AppScreen {
    @ObservedObject var vm: AppVM

    var bodyContent: some View {
        NavView(showDefaultNavBar: false) {
            SplashScreen.build()
        }
    }

}

extension AppView {

    static func build() -> some View {
        let vm = AppVM()
        return AppView(vm: vm)
    }

}

