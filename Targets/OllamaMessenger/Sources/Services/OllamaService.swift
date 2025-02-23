import Ollama

@MainActor
final class OllamaService {
    private static let llama3_2: Model.ID = "llama3.2"

    private let client = Client.default
    private var context = [Chat.Message]()

    func getAiAnswer(msg: String) async throws -> String {
        context.append(.user(msg))
        let response = try await client.chat(
            model: Self.llama3_2,
            messages: context
        )
        context.append(response.message)
        return response.message.content
    }
}
