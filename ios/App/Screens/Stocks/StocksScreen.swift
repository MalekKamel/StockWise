//
// Created by Kamel on 29/05/2023.
//

import SwiftUI
import Flutter

import SwiftUI
import Flutter

struct StocksScreen: AppScreen {
    @StateObject var vm: StocksVM
    @EnvironmentObject var navigator: Navigator

    @StateObject var flutterDependencies = FlutterDependencies()

    var bodyContent: some View {
        FlutterView()
    }
}

extension StocksScreen {

    static func build() -> some View {
        let api = FlutterStocksApi(binaryMessenger: UIApplication.binaryMessenger)
        let vm = StocksVM(stocksApi: api)
        return StocksScreen(vm: vm)
    }

}

struct StocksScreen_Previews: PreviewProvider {
    static var previews: some View {
        StocksScreen.build()
    }
}



