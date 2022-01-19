import SwiftUI
import HeyQiitaCore

struct AuthWebView: View {
  @ObservedObject var viewModel = AuthWebViewModel()

  var body: some View {
    WebView(url: viewModel.authURL)
  }
}

#if DEBUG || STUB
struct AuthWebView_Previews: PreviewProvider {
  static var previews: some View {
    AuthWebView()
  }
}
#endif
