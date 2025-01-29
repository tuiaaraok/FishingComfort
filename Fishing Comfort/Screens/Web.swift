import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let link: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    func updateUIView(_ webView: WKWebView, context: Context) {

            if let url = URL(string: link) {
                let request = URLRequest(url: url)
                webView.load(request)
            } else {
                print("Invalid URL: \(link)")
            }
    }
}


class Checking : ObservableObject{
    @Published var cheсk: Bool = false
    
    func containsSpecialCharacters(in url: String, characters: String) -> Bool {
        
            if url.contains(characters) {
                return true
            }else{
                return false
            }
       
    }
}

extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
