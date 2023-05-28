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
    @State private var isWebViewShowed: Bool = false
    var body: some View {
        NavigationStack {
            VStack {
                TextField(
                    "Search for Repositories",
                    text: $viewModel.searchText,
                    axis: .horizontal
                )
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
                List(viewModel.items) { item in
                    NavigationLink {
                        RepositoryWebView(item: item)
                            .onAppear {
                                viewModel.markRepoAsViewed(repoId: item.id)
                                RepositoryHistoryManager.shared.addVisitedRepo(item)
                            }
                    } label: {
                        RepositoryItemView(
                            item: item
                        )
                    }
                    .onAppear {
                        if shouldLoadMore(item) {
                            viewModel.incrementPage()
                        }
                    }
                }.listStyle(.plain)
                    .listRowInsets(
                        EdgeInsets(
                            top: 0,
                            leading: -8,
                            bottom: 0,
                            trailing: 0
                        )
                    )
                    .navigationBarTitle("Search for Repositories", displayMode: .inline)
            }
        }
    }
    
    private func shouldLoadMore(_ item: RepositoryItem) -> Bool {
        if let lastItem = viewModel.items.last,
           item.id == lastItem.id {
            return true
        }
        return false
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
