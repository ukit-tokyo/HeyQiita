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
}
