//
// Created by Kamel on 29/05/2023.
//

import SwiftUI
import Flutter

typealias MethodCallHandler = (_ call: FlutterMethodCall, _ result: @escaping FlutterResult) -> Void

struct FlutterView: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> FlutterViewController {
        FlutterViewController(project: nil, nibName: nil, bundle: nil)
    }

    func updateUIViewController(_ uiViewController: FlutterViewController, context: Context) {
    }
}

struct StocksScreen: AppScreen {
    @ObservedObject var vm: StocksVM
    @EnvironmentObject var navigator: Navigator

    @StateObject var flutterDependencies = FlutterDependencies()

    var bodyContent: some View {
        FlutterView()
    }
}

extension StocksScreen {

    static func build() -> some View {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let api = FlutterStocksApi(binaryMessenger: appDelegate.engine.binaryMessenger)
        let vm = StocksVM(stocksApi: api)
        return StocksScreen(vm: vm)
    }

}

struct StocksScreen_Previews: PreviewProvider {
    static var previews: some View {
        StocksScreen.build()
    }
}



