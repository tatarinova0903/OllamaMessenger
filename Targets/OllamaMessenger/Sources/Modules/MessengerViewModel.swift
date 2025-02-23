import SwiftUI
import Ollama

@MainActor
final class MessengerViewModel: ObservableObject {

    @Published
    var state = MessengerViewState.empty

    private let ollamaService: OllamaService

    init(ollamaService: OllamaService) {
        self.ollamaService = ollamaService
    }

    func getAiAnswer(userMessage: String) async {
        state.addMessage(
            msg: MessengerViewState.Message(
                owner: .user,
                content: userMessage,
                error: nil
            )
        )
        do {
            let aiMessage = try await ollamaService.getAiAnswer(msg: userMessage)
            state.addMessage(
                msg: MessengerViewState.Message(
                    owner: .ai,
                    content: aiMessage,
                    error: nil
                )
            )
        } catch {
            state.setErrorToLastMessage()
        }
    }

}

enum MessengerViewState {
    typealias AiError = String

    struct Message: Identifiable {

        enum Owner {
            case user, ai

            var string: String {
                switch self {
                case .user:
                    "You"
                case .ai:
                    "Baby Yoda"
                }
            }
        }

        let id = UUID()
        let owner: Owner
        let content: String
        private(set) var error: AiError?
    }

    case chat([Message])
    case empty

    mutating func addMessage(msg: Message) {
        switch self {
        case .chat(var messages):
            messages.append(msg)
            self = .chat(messages)
        case .empty:
            self = .chat([msg])
        }
    }

    mutating func setErrorToLastMessage() {
        // TODO: - error handling
    }
}
