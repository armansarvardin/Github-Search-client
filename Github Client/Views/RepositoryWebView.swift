//
//  WebView.swift
//  Github Client
//
//  Created by Arman Sarvardin on 26.05.2023.
//

import Foundation

import SwiftUI
import WebKit

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
    var body: some View {
        NavigationView {
            WebView(url: URL(string: "https://www.example.com")!)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct RepositoryWebView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryWebView()
    }
}
