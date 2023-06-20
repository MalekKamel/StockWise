//
// Created by Kamel on 13/01/2023.
// Copyright (c) 2023 sha. All rights reserved.
//

import SwiftUI

import SwiftUI

public struct TextView: UIViewRepresentable {
    private var text: String
    private var font: UIFont
    private var foregroundColor: Color

    public init(
            _ text: String,
            font: UIFont,
            foregroundColor: Color) {
        self.text = text
        self.font = font
        self.foregroundColor = foregroundColor
    }

    public func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()

        textView.delegate = context.coordinator
        textView.font = font
        textView.autocapitalizationType = .sentences
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.textContainer.maximumNumberOfLines = 0
        textView.textContainer.lineBreakMode = .byTruncatingTail
        textView.textColor = UIColor(foregroundColor)

        return textView
    }

    public func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        uiView.font = font
        uiView.isScrollEnabled = true
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    public class Coordinator: NSObject, UITextViewDelegate {

        public func textViewDidChange(_ textView: UITextView) {
        }
    }
}