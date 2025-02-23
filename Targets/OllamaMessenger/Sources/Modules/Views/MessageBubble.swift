import SwiftUI

struct MessageBubble: View {

    private let model: MessengerViewState.Message

    init(model: MessengerViewState.Message) {
        self.model = model
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(model.owner.string)
                .foregroundStyle(model.owner.authorColor)
                .fontWeight(.bold)

            Text(model.content)
                .foregroundStyle(model.owner.textColor)
        }
        .padding()
        .background(model.owner.bubbleColor)
        .clipShape(RoundedRectangle(cornerRadius: 16.0))
    }
}

extension MessengerViewState.Message.Owner {

    fileprivate var bubbleColor: Color {
        switch self {
        case .user:
            OllamaColors.accent
        case .ai:
            OllamaColors.accentSuperLight
        }
    }

    fileprivate var authorColor: Color {
        switch self {
        case .user:
            OllamaColors.light
        case .ai:
            OllamaColors.accent
        }
    }

    fileprivate var textColor: Color {
        OllamaColors.light
    }
}
