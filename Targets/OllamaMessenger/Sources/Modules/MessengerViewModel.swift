import SwiftUI
import Ollama

@MainActor
final class MessengerViewModel: ObservableObject {
    @Published
    var state = MessengerViewState.content("")

    private let ollamaService: OllamaService

    init(ollamaService: OllamaService) {
        self.ollamaService = ollamaService
    }

    func getModelAnswer(userMessage: String) async {
        do {
            let aiResponse = try await ollamaService.sendMessage(msg: userMessage)
            state = .content(aiResponse)
        } catch {
            state = .error("Error: \(error)")
        }
    }
}

enum MessengerViewState {
    case content(String)
    case error(String)
}
