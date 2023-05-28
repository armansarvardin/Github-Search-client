//
//  SavedReposView.swift
//  Github Client
//
//  Created by Arman Sarvardin on 26.05.2023.
//

import SwiftUI
import Domain

struct RepositoryHistoryView: View {
    @ObservedObject var viewModel = RepositoryHistoryViewModel()
    var body: some View {
        NavigationView {
            List(viewModel.visitedItems) { item in
                NavigationLink {
                    RepositoryWebView(item: item)
                } label: {
                    RepositoryItemView(item: item)
                }

            }.listStyle(.plain)
                .navigationTitle("History")
        }
    }
}

struct RepositoryHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryHistoryView()
    }
}
