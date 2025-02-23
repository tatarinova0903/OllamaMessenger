import SwiftUI

struct MessageBubble: View {

    private let model: MessengerViewState.Message

    init(model: MessengerViewState.Message) {
        self.model = model
    }

    var body: some View {
        VStack {
            Text(model.owner.string)
            
            Text(model.content)
        }
    }
}
