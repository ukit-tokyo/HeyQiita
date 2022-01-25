import WebKit

/// WKWebView
final class WebViewContainer: WKWebView {
  /// Webリクエスト毎直前にコール
  /// - return: リクエストをキャンセルする場合は true
  private let willLoad: ((URL) -> (Bool))?

  init(url: URL, willLoad: ((URL) -> (Bool))? = nil) {
    self.willLoad = willLoad
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
    if let url = navigationAction.request.url {
      let shouldLoadCancel = willLoad?(url) ?? false
      if shouldLoadCancel {
        decisionHandler(.cancel)
        return
      }
    }
    decisionHandler(.allow)
  }
}
