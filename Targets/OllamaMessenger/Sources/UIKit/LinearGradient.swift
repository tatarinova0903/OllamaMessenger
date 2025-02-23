import SwiftUI

extension LinearGradient {
    static let main = LinearGradient(
        stops: [
            Gradient.Stop(color: OllamaColors.accentLight, location: 0.0),
            Gradient.Stop(color: OllamaColors.dark, location: 0.3)
        ],
        startPoint: .top,
        endPoint: .bottom
    )
}
