//
//  AuthorizedView.swift
//  Github Client
//
//  Created by Arman Sarvardin on 29.05.2023.
//

import SwiftUI

struct AuthorizedView: View {
    var body: some View {
        TabView {
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            RepositoryHistoryView()
                .tabItem {
                    Label("History", systemImage: "clock")
                }
            UserProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
        .background(.foreground)
        .accentColor(.primary)
    }
}

struct AuthorizedView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorizedView()
    }
}
