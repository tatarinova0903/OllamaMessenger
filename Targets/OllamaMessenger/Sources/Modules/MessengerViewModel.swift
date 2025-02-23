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
                content: .ready(userMessage)
            )
        )
        state.addLoading(owner: .ai)
        do {
            let aiMessage = try await ollamaService.getAiAnswer(msg: userMessage)
            state.dropLastLoading()
            state.addMessage(
                msg: MessengerViewState.Message(
                    owner: .ai,
                    content: .ready(aiMessage)
                )
            )
        } catch {
            state.dropLastLoading()
            state.setErrorToLastMessage()
        }
    }

}

enum MessengerViewState {
    typealias AiError = String

    struct Message: Identifiable {

        enum Owner {
            case user, ai
        }

        enum Content {
            case ready(String)
            case loading
        }

        let id = UUID()
        let owner: Owner
        let content: Content
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

    mutating func addLoading(owner: Message.Owner) {
        switch self {
        case .chat(var messages):
            messages.append(Message(owner: owner, content: .loading))
            self = .chat(messages)

        case .empty:
            self = .chat([Message(owner: owner, content: .loading)])
        }
    }

    mutating func dropLastLoading() {
        switch self {
        case .chat(var messages):
            if let last = messages.last,
               case .loading = last.content {
                messages = messages.dropLast()
            }
            self = .chat(messages)

        case .empty:
            return
        }
    }

    mutating func setErrorToLastMessage() {
        // TODO: - error handling
    }
}
