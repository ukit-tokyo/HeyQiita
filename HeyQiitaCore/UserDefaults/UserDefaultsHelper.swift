final class UserDefaultsHelper {
  private enum Key {
    static let isLoginPending = "is_login_pending"
  }

  static let shared = UserDefaultsHelper()

  private let userDefaults: UserDefaults

  private init() {
    userDefaults = UserDefaults.standard
  }
}

extension UserDefaultsHelper {
  /// ログインスキップ中フラグ
  var isLoginPending: Bool {
    get { userDefaults.bool(forKey: Key.isLoginPending) }
    set { userDefaults.set(newValue, forKey: Key.isLoginPending) }
  }
}
