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
        VStack(spacing: 0) {
            List(viewModel.state.messages) { message in
                messageElement(message: message)
                    .listRowSeparator(.hidden)
            }
            .scrollContentBackground(.hidden)
            .background(
                .linearGradient(
                    stops: [
                        Gradient.Stop(color: OllamaColors.accentLight, location: 0.0),
                        Gradient.Stop(color: OllamaColors.dark, location: 0.3)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )

            inputField()
        }
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

    @ViewBuilder
    private func inputField() -> some View {
        VStack {
            TextField("Your message", text: $userMessage)
            Button(
                action: {
                    let question = userMessage
                    userMessage = ""
                    Task {
                        await viewModel.getAiAnswer(userMessage: question)
                    }
                },
                label: {
                    Text("Get answer")
                }
            )
        }
    }

}
