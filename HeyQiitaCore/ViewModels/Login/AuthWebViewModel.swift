import HeyQiitaNetwork

public class AuthWebViewModel: ObservableObject {
  public let authURL: URL

  public init() {
    guard let clientID = Bundle.main.object(forInfoDictionaryKey: "CLIENT_ID") as? String else {
      fatalError("CLIENT_ID was not found.")
    }
    authURL = URL.authURL
      .addQueries([
        URLQueryItem(name: "client_id", value: clientID),
        URLQueryItem(name: "scope", value: "read_qiita+write_qiita")
      ])!
  }

  /// 認証コードを含むURLをフック
  /// - Parameter url: 検証URL
  /// - Returns: 対象のリダイレクトURLから認証コードを取得できたら  true
  public func hookAuthCodeFromTargetURL(url: URL) -> Bool {
    guard url.host == URL.redirectURL.host,
          let code = url.getQuery(name: "code") else { return false }
    print("testing...", code)
    return true
  }
}
