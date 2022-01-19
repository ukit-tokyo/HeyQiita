import WebKit

/// WKWebView
class WebViewContainer: WKWebView {

  init(url: URL) {
    super.init(frame: .zero, configuration: WKWebViewConfiguration())
    navigationDelegate = self
    load(URLRequest(url: url))
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension WebViewContainer: WKNavigationDelegate {
  func webView(
    _ webView: WKWebView,
    decidePolicyFor navigationAction: WKNavigationAction,
    decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
  ) {
    decisionHandler(.allow)
  }
}
