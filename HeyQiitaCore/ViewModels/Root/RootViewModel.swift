import HeyQiitaNetwork
import Combine

public final class RootViewModel: ObservableObject {
  public static let shared = RootViewModel()

  @Published public var alert: APIErrorAlert
  @Published public var userStatus: UserStatus
  public var isLoginChecked: Bool {
    return userStatus.isAuthenticated
      || userStatus.isLoginPending
  }

  private init() {
    alert = APIErrorAlert()
    userStatus = UserStatus()
  }

  public func resetAlert() {
    alert.update(show: false, message: nil)
  }

  func catchAPIError(_ error: SessionError) {
    alert.update(show: true, message: error.body?.message)
  }

  func update(userStatus: UserStatus) {
    self.userStatus = userStatus
  }
}

extension RootViewModel {
  public class APIErrorAlert {
    @Published public var isShown: Bool = false
    public private(set) var message: String?

    func update(show: Bool, message: String?) {
      self.message = message
      self.isShown = show
    }
  }

  public class UserStatus {
    /// 認証済みフラグ
    public var isAuthenticated: Bool {
      KeyChainHelper.shared.accessToken != nil
    }
    /// ログインをスキップ中か
    @Published public var isLoginPending: Bool = false

    public init(isLoginPending: Bool = false) {
      self.isLoginPending = isLoginPending
    }
  }
}
