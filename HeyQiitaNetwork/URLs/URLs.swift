public extension URL {
  static let authURL: URL = URL(string: "https://qiita.com/api/v2/oauth/authorize")!
  static let redirectURL: URL = URL(string: "https://hey-qiita.tokyo")!
}

public extension URL {
  /// クエリ追加ヘルパー
  /// - Parameters:
  ///   - name: key
  ///   - value: value
  /// - Returns: クエリ追加後のURL
  func addQuery(name: String,  value: String?) -> URL? {
    addQueries([URLQueryItem(name: name, value: value)])
  }

  /// クエリ追加ヘルパー
  /// - Parameters:
  ///   - queryItems:URLQueryItem配列
  /// - Returns: クエリ追加後のURL
  func addQueries(_ queryItems: [URLQueryItem]) -> URL? {
    guard var components = URLComponents(url: self, resolvingAgainstBaseURL: baseURL != nil) else {
      return nil
    }
    components.queryItems = (components.queryItems ?? []) + queryItems
    return components.url
  }

  /// 対象クエリ取得ヘルパー
  /// - Parameter key: 欲しいクエリのKey名
  /// - Returns: 指定したKeyのValue
  func getQuery(name: String) -> String? {
    return URLComponents(url: self, resolvingAgainstBaseURL: true)?
      .queryItems?
      .first(where: { $0.name == name })?
      .value
  }
}
