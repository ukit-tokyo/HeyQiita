import HeyQiitaCore
import SwiftUI


struct RootView: View {
  @ObservedObject private var viewModel = RootViewModel.shared

  var body: some View {
    if viewModel.isLoginChecked {
      HomeView()
    } else {
      LoginView()
    }
      /*
      .alert(
        "Network Error",
        isPresented: $viewModel.alert.isShown,
        actions: {
          Button("OK") {
            viewModel.alert.isShown = false
          }
        },
        message: { Text(viewModel.alert.message ?? "") }
      )
       */
  }
}

#if DEBUG || STUB
struct RootView_Previews: PreviewProvider {
  static var previews: some View {
    RootView()
  }
}
#endif
