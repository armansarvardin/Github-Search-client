//
//  Github_ClientApp.swift
//  Github Client
//
//  Created by Arman Sarvardin on 25.05.2023.
//

import SwiftUI
import Domain

@main
struct Github_ClientApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @AppStorage(GlobalContants.isAuthorized) var isAuthorized = false
    @State private var isAuthed = false
    var body: some Scene {
        WindowGroup {
            ContentView()
//            if isAuthorized {
//                TabView {
//                    SearchView()
//                        .tabItem {
//                            Label("Search", systemImage: "magnifyingglass")
//                        }
//                    RepositoryHistoryView()
//                        .tabItem {
//                            Label("History", systemImage: "clock")
//                        }
//                    UserProfileView()
//                        .tabItem {
//                            Label("Profile", systemImage: "person")
//                        }
//                }
//                .background(.foreground)
//                .accentColor(.primary)
//                    .opacity(isAuthorized ? 1 : 0)
//            } else {
//                ContentView()
//                    .onReceive(NotificationCenter.default.publisher(for: .authorizationEvent)) { output in
//                        withAnimation(Animation.easeInOut(duration: 0.7)) {
//                            if let value = output.object as? Bool {
//                                isAuthorized = value
//                                isAuthed = value
//                            }
//                        }
//                    }
//                    .opacity(isAuthorized ? 0 : 1)
//            }
        }
    }
}


