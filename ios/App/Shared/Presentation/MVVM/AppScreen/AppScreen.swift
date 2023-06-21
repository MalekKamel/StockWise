//
// Created by Kamel on 04/04/2021.
//

import SwiftUI

/// A protocol that abstracts the common functionalities of a screen
/// The screen represents the main container that covers all the device screen.
/// NOT a single component.
protocol AppScreen: View, Reportable {
    associatedtype Content: View
    associatedtype Background: View
    associatedtype StatusBarBackground: View
    associatedtype ViewModel: AppViewModel

// TODO: reimplement vm later
    /// The viewModel of this screen
    var vm: ViewModel { get set }
    var backgroundColor: Background { get }
    var statusBarBackground: StatusBarBackground { get }
    var statusBarHeight: CGFloat { get }

    var hasNavbar: Bool { get }

    /// The normal content view that should be shown to
    /// the user in the normal state.
    /// - Returns: Content
    @ViewBuilder var bodyContent: Content { get }

    /// Called when the root view appears.
    func onAppear()

    /// Called when the root view disappears.
    func onDisappear()
}

extension AppScreen {
    var body: some View {
        Group {
            if #available(iOS 15.0, *), BuildConfig.isDebug {
                let _ = Self._printChanges()
            }
            VStack(spacing: 0) {
                VStack {
                    InfiniteWidthSpacer().frame(height: statusBarHeight)
                }
                        .background(statusBarBackground)
                bodyContent
            }
                    .background(backgroundColor)
                    .hideNavigationBar(!hasNavbar)
                    .applyIf(ignoresSafeArea) { view in
                        view.ignoresSafeArea(.all)
                    }
                    .environment(\.layoutDirection, AppLanguage.layoutDirection)
                    .onAppear(perform: onAppear)
                    .onDisappear(perform: onDisappear)
        }
    }

    func onAppear() {
    }

    func onDisappear() {
    }

    var hasNavbar: Bool {
        true
    }

    var ignoresSafeArea: Bool {
        false
    }

    var backgroundColor: some View {
        Color.clear
    }

    var statusBarHeight: CGFloat {
        // TODO: calculate the height of status bar when needed
        0
    }

    var statusBarBackground: some View {
        backgroundColor
    }

}

