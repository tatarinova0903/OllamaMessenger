import SwiftUI

enum OllamaColors {
    static let light = Color(hex: 0xFFFFFF)
    static let dark = Color(hex: 0x10242F)
    static let accent = Color(hex: 0x40D2BA)
    static let accentLight = Color(hex: 0x40D2BA, alpha: 0.5)
    static let accentSuperLight = Color(hex: 0x40D2BA, alpha: 0.2)
}


extension Color {
    
    fileprivate init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
