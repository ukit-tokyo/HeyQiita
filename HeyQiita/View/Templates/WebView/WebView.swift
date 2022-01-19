import SwiftUI

/// 共通 WebView
struct WebView: UIViewRepresentable {
  let url: URL

  func makeUIView(context: Context) -> WebViewContainer {
    WebViewContainer(url: url)
  }

  func updateUIView(_ uiView: WebViewContainer, context: Context) {
    uiView.load(URLRequest(url: url))
  }
}

struct WebView_Previews: PreviewProvider {
  static var previews: some View {
    WebView(url: URL(string: "https://www.google.com")!)
  }
}
