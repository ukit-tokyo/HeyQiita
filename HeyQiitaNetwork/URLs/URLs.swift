public extension URL {
  static let authURL: URL = URL(string: "https://qiita.com/api/v2/oauth/authorize")!
}

public extension URL {
  /// クエリ追加ヘルパー
  func addQuery(name: String,  value: String?) -> URL! {
    addQueries([URLQueryItem(name: name, value: value)])
  }

  func addQueries(_ queryItems: [URLQueryItem]) -> URL? {
    guard var components = URLComponents(url: self, resolvingAgainstBaseURL: baseURL != nil) else {
      return nil
    }
    components.queryItems = (components.queryItems ?? []) + queryItems
    return components.url
  }
}
