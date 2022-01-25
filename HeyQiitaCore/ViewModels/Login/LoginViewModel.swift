public class LoginViewModel: ObservableObject {
  @Published public var isAuthWebViewPresented: Bool = false

  public init() {}

  public func setAuthCompleted() {
    RootViewModel.shared.update(userStatus: .init())
  }
}
