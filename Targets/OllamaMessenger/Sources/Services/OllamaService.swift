import Ollama

@MainActor
final class OllamaService {
    private let client = Client.default
    private let model: Model.ID = "llama3.2"

    func sendMessage(msg: String) async throws -> String {
        let response = try await client.chat(
            model: model,
            messages: [
                .user(msg)
            ]
        )
        return response.message.content
    }
}
