//
//  WebView.swift
//  fianl_Game
//
//  Created by 陳奇松 on 2021/6/18.
//

import Foundation
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        if let url = URL(string: "https://picrew.me/image_maker/1156440") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
    
    typealias UIViewType = WKWebView
    
    
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView()
    }
}
