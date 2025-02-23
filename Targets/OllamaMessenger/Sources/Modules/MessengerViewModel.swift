import SwiftUI
import Ollama

@MainActor
final class MessengerViewModel: ObservableObject {

    @Published
    var state = MessengerViewState(messages: [])

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

struct MessengerViewState {
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

    private(set) var messages: [Message]

    mutating func addMessage(msg: Message) {
        messages.append(msg)
    }

    mutating func setErrorToLastMessage() {
        // TODO: - error handling
    }
}
