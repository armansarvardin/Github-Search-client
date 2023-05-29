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
            AuthView()
        }
    }
}


