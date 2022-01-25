import SwiftUI

/// 共通 WebView
struct WebView: UIViewRepresentable {
  let url: URL
  let willLoad: ((URL) -> (Bool))?

  init(url: URL, willLoad: ((URL) -> (Bool))? = nil) {
    self.url = url
    self.willLoad = willLoad
  }

  func makeUIView(context: Context) -> WebViewContainer {
    WebViewContainer(url: url, willLoad: willLoad)
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
