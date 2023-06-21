import SwiftUI
import UIKit

struct Spinner: UIViewRepresentable {
    let style: UIActivityIndicatorView.Style
    var deadline: DispatchTime? = nil

    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(style: style)
        spinner.hidesWhenStopped = true
        spinner.startAnimating()

        if let deadline {
            DispatchQueue.main.asyncAfter(deadline: deadline) {
                spinner.stopAnimating()
            }
        }
        return spinner
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
    }
}
