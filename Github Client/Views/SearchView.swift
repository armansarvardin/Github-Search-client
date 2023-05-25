//
//  ContentView.swift
//  Github Client
//
//  Created by Arman Sarvardin on 25.05.2023.
//

import SwiftUI
import Domain
import Combine

struct SearchView: View {
    @State var searchPattern = ""
    @ObservedObject var viewModel = SearchViewModel()
    var body: some View {
        VStack {
            TextField(
                "Search for Repositories",
                text: $searchPattern,
                axis: .horizontal
            ).onAppear {
                NotificationCenter.default.addObserver(
                    forName: UITextField.textDidChangeNotification,
                    object: nil,
                    queue: nil
                ) { notification in
                    guard let textField = notification.object as? UITextField else {
                        return
                    }
                    
                    if let newText = textField.text {
                        self.viewModel.performSearch(by: newText)
                    }
                }
            }
            .padding(8)
            .textFieldStyle(.plain)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.primary, lineWidth: 1)
                HStack {
                    Spacer()
                    Image(systemName: "magnifyingglass")
                        .padding(.trailing, 16)
                }
            }
            .padding(8)
            List {
                
            }
        }.onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
