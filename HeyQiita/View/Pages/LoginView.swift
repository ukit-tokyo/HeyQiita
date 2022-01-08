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

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView()
  }
}
