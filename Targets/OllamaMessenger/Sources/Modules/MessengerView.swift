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
        switch viewModel.state {
        case .error(let model):
            error(model: model)
        case .content(let model):
            content(model: model)
        }
    }

    @ViewBuilder
    private func content(model: String) -> some View {
        VStack {
            TextField("Your message", text: $userMessage)
            Button(
                action: {
                    Task {
                        await viewModel.getModelAnswer(userMessage: userMessage)
                    }
                },
                label: {
                    Text("Get answer")
                }
            )
            Text(model)
        }
    }

    @ViewBuilder
    private func error(model: String) -> some View {
        Text(model)
    }

}
