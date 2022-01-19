import SwiftUI
import HeyQiitaCore

struct AuthWebView: View {
  @ObservedObject var viewModel: AuthWebViewModel

  init(didAuthComplete: @escaping () -> Void) {
    viewModel = AuthWebViewModel(didAuthComplete: didAuthComplete)
  }

  var body: some View {
    WebView(
      url: viewModel.authURL,
      willLoad: { url in
        print("testing...", url)
        return viewModel.hookAuthCodeFromTargetURL(url: url)
      })
  }
}

#if DEBUG || STUB
struct AuthWebView_Previews: PreviewProvider {
  static var previews: some View {
    AuthWebView(didAuthComplete: {})
  }
}
#endif
