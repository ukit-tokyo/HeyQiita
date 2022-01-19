import SwiftUI

struct AuthWebView: View {
  var body: some View {
    WebView(url: URL(string: "https://www.google.com")!)
  }
}

struct AuthWebView_Previews: PreviewProvider {
  static var previews: some View {
    AuthWebView()
  }
}
