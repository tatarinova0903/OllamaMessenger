import SwiftUI

struct EmptyView: View {

    var body: some View {
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
    }
    
}
