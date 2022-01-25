import KeychainAccess

final class KeyChainHelper {
  private enum Key {
    static let accessToken = "access_token"
  }

  static let shared = KeyChainHelper()

  private let keychain: Keychain

  private init() {
    guard let bundleID = Bundle.main.bundleIdentifier else {
      fatalError("Bundle ID not found")
    }
    keychain = Keychain(service: bundleID)
  }
}

extension KeyChainHelper {
  /// アクセストークン
  var accessToken: String? {
    get { try? keychain.getString(Key.accessToken) }
    set { keychain[Key.accessToken] = newValue }
  }
}
