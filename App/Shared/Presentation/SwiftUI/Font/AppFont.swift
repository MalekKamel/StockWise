//
// Created by Kamel on 15/12/2022.
//

import SwiftUI

public enum FontWeight {
    case bold
    case semiBold
    case extraBold
    case light
    case regular
}

public extension View {

    func appFontBold(size: CGFloat) -> some View {
        appFont(size: size, weight: .bold)
    }

    func appFontExtraBold(size: CGFloat) -> some View {
        appFont(size: size, weight: .extraBold)
    }

    func appFontSemiBold(size: CGFloat) -> some View {
        appFont(size: size, weight: .semiBold)
    }

    func appFontLight(size: CGFloat) -> some View {
        appFont(size: size, weight: .light)
    }

    func appFontRegular(size: CGFloat) -> some View {
        appFont(size: size, weight: .regular)
    }

    func appFont(size: CGFloat, weight: FontWeight = .regular) -> some View {
        switch weight {
        case .bold:
            return font(FontFamily.Inter.bold.swiftUiFont(size: size))
        case .extraBold:
            return font(FontFamily.Inter.extraBold.swiftUiFont(size: size))
        case .semiBold:
            return font(FontFamily.Inter.extraBold.swiftUiFont(size: size))
        case .light:
            return font(FontFamily.Inter.light.swiftUiFont(size: size))
        case .regular:
            return font(FontFamily.Inter.regular.swiftUiFont(size: size))
        }
    }
}

public extension Text {

    func appFontBold(size: CGFloat) -> Text {
        appFont(size: size, weight: .bold)
    }

    func appFontSemiBold(size: CGFloat) -> some View {
        appFont(size: size, weight: .semiBold)
    }

    func appFontExtraBold(size: CGFloat) -> Text {
        appFont(size: size, weight: .extraBold)
    }

    func appFontLight(size: CGFloat) -> Text {
        appFont(size: size, weight: .light)
    }

    func appFontRegular(size: CGFloat) -> Text {
        appFont(size: size, weight: .regular)
    }

    func appFont(size: CGFloat, weight: FontWeight = .regular) -> Text {
        switch weight {
        case .bold:
            return font(FontFamily.Inter.bold.swiftUiFont(size: size))
        case .extraBold:
            return font(FontFamily.Inter.extraBold.swiftUiFont(size: size))
        case .semiBold:
            return font(FontFamily.Inter.extraBold.swiftUiFont(size: size))
        case .light:
            return font(FontFamily.Inter.light.swiftUiFont(size: size))
        case .regular:
            return font(FontFamily.Inter.regular.swiftUiFont(size: size))
        }
    }
}

