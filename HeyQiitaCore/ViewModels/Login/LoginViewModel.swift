public class LoginViewModel: ObservableObject {
  @Published public var isAuthWebViewPresented: Bool = false

  public init() {}

  public func set(accessToken: String) {
    KeyChainHelper.shared.accessToken = accessToken
    RootViewModel.shared.update(userStatus: .init())
  }

  public func setLoginSkipped() {
    UserDefaultsHelper.shared.isLoginPending = true
    RootViewModel.shared.update(userStatus: .init())
  }
}
