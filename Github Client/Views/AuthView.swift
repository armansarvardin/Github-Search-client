import SwiftUI
import Domain

struct ContentView: View {
    @ObservedObject private var viewModel = AuthViewModel()
    var body: some View {
        NavigationView {
            VStack {
                Button {
                    viewModel.signIn()
                } label: {
                    Text("Authenticate to Github")
                        .padding()
                        .background(.background)
                        .cornerRadius(4)
                }.fullScreenCover(isPresented: $viewModel.isAuthorized) {
                    AuthorizedView()
                }
            }
        }
    }
}
