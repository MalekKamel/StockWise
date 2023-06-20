//
// Created by Kamel on 15/12/2022.
//

import SwiftUI

public extension String {
    var hexToSwiftUIColor: Color {
        ColorConverter.from(hex: self)
    }
}

public struct ColorConverter {
    public static func from(hex: String) -> Color {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return Color.gray
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return Color(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                opacity: CGFloat(1.0)
        )
    }

    public static func from(hex: String) -> ColorComponents {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return ColorComponents(
                    red: 0,
                    green: 0,
                    blue: 0,
                    opacity: CGFloat(1.0))
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return ColorComponents(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                opacity: CGFloat(1.0)
        )
    }
}

public struct ColorComponents {
    let red: CGFloat
    let green: CGFloat
    let blue: CGFloat
    let opacity: CGFloat
}

extension Color {

    init(hex: String) {
        let components: ColorComponents = ColorConverter.from(hex: hex)
        self.init(
                red: components.red,
                green: components.green,
                blue: components.blue,
                opacity: components.opacity
        )
    }

}

