import SwiftUI
import Ollama

@MainActor
final class MessengerViewModel: ObservableObject {
    @Published
    var state = MessengerViewState.content("")

    private let client = Client.default

    func getModelAnswer(userMessage: String) async {
        do {
            let response = try await client.chat(
                model: "llama3.2",
                messages: [
                    .user(userMessage)
                ]
            )
            state = .content(response.message.content)
        } catch {
            state = .error("Error: \(error)")
        }
    }
}

enum MessengerViewState {
    case content(String)
    case error(String)
}
