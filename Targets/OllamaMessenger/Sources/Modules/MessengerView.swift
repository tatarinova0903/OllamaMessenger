import SwiftUI

struct MessengerView: View {

    @StateObject
    private var viewModel: MessengerViewModel
    @State
    private var userMessage = ""

    init(viewModel: MessengerViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(spacing: 0.0) {
            main()
                .background(LinearGradient.main)

            InputView(input: userMessage, didEnter: viewModel.getAiAnswer(userMessage:))
                .padding(.horizontal, 6.0)
                .padding(.bottom, 6.0)
                .background(OllamaColors.dark)
        }
    }

    @ViewBuilder
    private func main() -> some View {
        switch viewModel.state {
        case .empty:
            EmptyView()

        case .chat(let messages):
            chat(messages: messages)
        }
    }

    @ViewBuilder
    private func chat(messages: [MessengerViewState.Message]) -> some View {
        List(messages) { message in
            messageElement(message: message)
                .listRowSeparator(.hidden)
        }
        .scrollContentBackground(.hidden)
    }

    @ViewBuilder
    private func messageElement(message: MessengerViewState.Message) -> some View {
        switch message.owner {
        case .user:
            HStack {
                Spacer()
                MessageBubble(model: message)
            }
        case .ai:
            HStack {
                MessageBubble(model: message)
                Spacer()
            }
        }
    }

}
