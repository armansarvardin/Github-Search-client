//
//  WebView.swift
//  Github Client
//
//  Created by Arman Sarvardin on 26.05.2023.
//

import SwiftUI
import WebKit
import Domain

struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

struct RepositoryWebView: View {
    let item: RepositoryItem
    init(item: RepositoryItem) {
        self.item = item
    }
    var body: some View {
        WebView(url: URL(string: item.url)!)
            .edgesIgnoringSafeArea(.all)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(item.fullName)
    }
}

extension UINavigationController {
    // Remove back button text
    open override func viewWillLayoutSubviews() {
        navigationBar.backgroundColor = .systemBackground
        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationBar.alpha = 1
        self.navigationBar.isTranslucent = true
        self.tabBarController?.tabBar.isTranslucent = true
        self.tabBarController?.tabBar.alpha = 1
    }
}
