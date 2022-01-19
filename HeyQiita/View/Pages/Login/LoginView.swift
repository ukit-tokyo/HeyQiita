import SwiftUI
import HeyQiitaCore

/// ログイン画面
struct LoginView: View {
  @ObservedObject var viewModel = LoginViewModel()

  var body: some View {
    VStack(spacing: 150) {
      AppLogo(fontSize: 50)

      HStack(spacing: 20) {
        AppButton(
          title: "Login",
          action: { viewModel.isAuthWebViewPresented.toggle() })
          .sheet(
            isPresented: $viewModel.isAuthWebViewPresented,
            onDismiss: { viewModel.isAuthWebViewPresented.toggle() },
            content: { AuthWebView() }
          )

        TextButton(title: "Skipping", action: {})
      }
    }
  }
}

#if DEBUG || STUB
struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      LoginView().preferredColorScheme(.dark)
      LoginView().preferredColorScheme(.light)
    }
  }
}
#endif
