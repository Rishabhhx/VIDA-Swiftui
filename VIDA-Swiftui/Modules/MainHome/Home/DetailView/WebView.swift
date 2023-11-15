//
//  WebView.swift
//  VIDA-Swiftui
//
//  Created by Rishabh Sharma on 09/09/22.
//

import SwiftUI
import WebKit
 
struct WebView: UIViewRepresentable {
 
    typealias UIViewType = WKWebView
        
        let webView: WKWebView
        
        func makeUIView(context: Context) -> WKWebView {
            webView
        }
        func updateUIView(_ uiView: WKWebView, context: Context) {
        }
}

final class WebViewModel: ObservableObject {
    
    @Published var urlString = "https://www.apple.com"
    
    let webView: WKWebView
    init() {
        webView = WKWebView(frame: .zero)
    }
    
    func loadUrl() {
        guard let url = URL(string: urlString) else {
            return
        }
        webView.load(URLRequest(url: url))
    }
    
    func back() {
      webView.goBack()
    }
    
    func forward() {
      webView.goForward()
    }
    
}
