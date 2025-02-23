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
        VStack {
            TextField("Your message", text: $input)
            Button(
                action: {
                    let question = input
                    input = ""
                    Task {
                        await didEnter(question)
                    }
                },
                label: {
                    Text("Get answer")
                }
            )
        }
    }
    
}
