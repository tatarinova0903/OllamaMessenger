import SwiftUI

struct TypingActivity: View {

    @State private var opacity = 1.0

    private let animation = Animation
        .linear
        .speed(0.3)
        .repeatForever(autoreverses: false)

    var body: some View {
        HStack(spacing: 3.0) {
            ForEach(0..<3) { index in
                dot()
            }
        }
        .opacity(opacity)
        .onAppear {
            withAnimation(animation) {
                opacity = 0.0
            }
        }
    }

    @ViewBuilder
    private func dot() -> some View {
        Circle()
            .foregroundStyle(OllamaColors.accent)
            .frame(width: 6.0)
    }

}
