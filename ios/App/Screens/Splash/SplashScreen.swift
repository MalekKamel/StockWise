//
// Created by Kamel on 29/05/2023.
//

import SwiftUI
import Flutter

struct SplashScreen: AppScreen {
    @ObservedObject var vm: SplashVM
    @EnvironmentObject var navigator: Navigator

    var bodyContent: some View {
            VStack(alignment: .center) {
                Assets.bgApp.swiftUiImage
                        .resizable()
                        .frame(width: 150, height: 150)
            }
                    .infiniteSize()
    }

    func onAppear() {
        handleFlow()
    }

    private func handleFlow() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            navigator.navigate {
                StocksScreen.build()
            }
        }
    }
}


extension SplashScreen {


    func reportCounter() {
        vm.methodChannel?.invokeMethod("reportCounter", arguments: vm.count)
    }
}

extension SplashScreen {

    static func build() -> some View {
        let vm = SplashVM()
        return SplashScreen(vm: vm)
    }

}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen.build()
    }
}



