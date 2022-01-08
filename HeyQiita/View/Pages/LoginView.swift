import SwiftUI

/// ログイン画面
struct LoginView: View {
  var body: some View {
    VStack(spacing: 150) {
      AppLogo(fontSize: 50)
      HStack(spacing: 20) {
        AppButton(title: "Login", action: {})
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
