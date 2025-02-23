import SwiftUI

@main
struct OllamaMessengerApp: App {
    var body: some Scene {
        WindowGroup {
            MessengerView(viewModel: MessengerViewModel())
        }
    }
}
