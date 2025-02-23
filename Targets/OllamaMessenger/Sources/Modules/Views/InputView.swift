import SwiftUI

struct InputView: View {
    @State
    private var input: String
    private let didEnter: (String) async -> Void

    init(input: String, didEnter: @escaping (String) async -> Void) {
        self.input = input
        self.didEnter = didEnter
    }

    var body: some View {
        HStack(spacing: 0.0) {
            TextField("Start typing...", text: $input)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onSubmit {
                    submitInput()
                }

            Image(systemName: "paperplane.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .foregroundStyle(OllamaColors.accent)
                .padding(.all, 5)
                .frame(width: 33.0, height: 33.0)
                .onTapGesture {
                    submitInput()
                }
        }
    }

    private func submitInput() {
        let question = input
        input = ""
        Task {
            await didEnter(question)
        }
    }

}
