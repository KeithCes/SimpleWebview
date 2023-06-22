import SwiftUI


public struct SimpleWebview: View {
    let url: URL
    @State private var pageTitle = ""
    
    public init(url: URL) {
        self.url = url
    }
    
    public var body: some View {
        VStack {
            Text(pageTitle)
            
            WebView(url: url) { title in
                pageTitle = title
            })
        }
    }
}
