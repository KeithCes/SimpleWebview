import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    
    // Closure to pass the webpage title
    let onTitleUpdate: (String) -> Void
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        
        // Set the navigation delegate
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(onTitleUpdate: onTitleUpdate)
    }
    
    // Coordinator to handle navigation delegate callbacks
    class Coordinator: NSObject, WKNavigationDelegate {
        let onTitleUpdate: (String) -> Void
        
        init(onTitleUpdate: @escaping (String) -> Void) {
            self.onTitleUpdate = onTitleUpdate
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.evaluateJavaScript("document.title") { (result, error) in
                if let title = result as? String {
                    // Pass the title back to WebViewWrapper
                    self.onTitleUpdate(title)
                }
            }
        }
    }
}
