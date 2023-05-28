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
                    Text("Auth with Firebase")
                }.fullScreenCover(isPresented: $viewModel.isAuthorized) {
                    AuthorizedView()
                }
            }
        }
    }
}
