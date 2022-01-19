import HeyQiitaNetwork
import Combine

public class AuthWebViewModel: ObservableObject {
  private var cancellables: Set<AnyCancellable> = []

  private let clientID: String
  private let didAuthComplete: () -> ()
  public let authURL: URL

  public init(didAuthComplete: @escaping () -> ()) {
    guard let clientID = Bundle.main.object(forInfoDictionaryKey: "CLIENT_ID") as? String else {
      fatalError("CLIENT_ID was not found.")
    }
    self.clientID = clientID
    self.didAuthComplete = didAuthComplete
    self.authURL = URL.authURL
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
    getAccessToken(with: code)
    return true
  }

  /// アクセストークン取得
  public func getAccessToken(with code: String) {
    guard let clientSecret = Bundle.main.object(forInfoDictionaryKey: "CLIENT_SECRET") as? String else {
      fatalError("CLIENT_SECRET was not found.")
    }
    let parameter = AccessTokenRequest.Parameter(
      clientID: clientID,
      clientSecret: clientSecret,
      code: code
    )
    Session.shared.send(AccessTokenRequest(parameter)).sink(
      onReceivedValue: { [weak self] value in
        KeyChainHelper.shared.accessToken = value.token
        self?.didAuthComplete()
      },
      onFailure: { error in
        print(error)
      })
      .store(in: &cancellables)
  }
}
