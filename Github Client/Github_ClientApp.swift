//
//  Github_ClientApp.swift
//  Github Client
//
//  Created by Arman Sarvardin on 25.05.2023.
//

import SwiftUI

@main
struct Github_ClientApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            TabView {
                SearchView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
            }.accentColor(.primary)
        }
    }
}


