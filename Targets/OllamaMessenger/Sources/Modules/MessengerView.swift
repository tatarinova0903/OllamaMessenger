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
            if viewModel.state.messages.isEmpty {
                empty()
            } else {
                chat(messages: viewModel.state.messages)
            }

            InputView(input: userMessage, didEnter: viewModel.getAiAnswer(userMessage:))
                .padding(.horizontal, 6.0)
                .padding(.bottom, 6.0)
                .background(OllamaColors.dark)
        }
    }

    @ViewBuilder
    private func empty() -> some View {
        VStack(spacing: 8.0) {
            Spacer()

            Image(.yoda)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: 200)

            Text("Wanna chat with Baby Yoda?")
                .font(.title)
                .frame(maxWidth: .infinity)

            Spacer()
        }
        .background(LinearGradient.main)
    }

    @ViewBuilder
    private func chat(messages: [MessengerViewState.Message]) -> some View {
        List(messages) { message in
            messageElement(message: message)
                .listRowSeparator(.hidden)
        }
        .scrollContentBackground(.hidden)
        .background(LinearGradient.main)
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
