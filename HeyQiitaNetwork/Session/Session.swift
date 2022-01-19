import Combine

/// 共通 API 実行クラス
public struct Session {
  public static let shared = Session()

  private init() {}

  public func send<Request: RequestProtocol, Response>(_ request: Request)
    -> AnyPublisher<Response, Error> where Request.Response == Response
  {
    let req = makeRequest(with: request)
    let decorder = JSONDecoder()
    decorder.keyDecodingStrategy = .convertFromSnakeCase

    return URLSession.shared.dataTaskPublisher(for: req)
      .receive(on: DispatchQueue.main)
      .tryMap { (data, response) in
        // TODO: エラーハンドリング
        return data
      }
      .decode(type: Response.self, decoder: decorder)
      .eraseToAnyPublisher()
  }
}

// MARK: - Helper
extension Session {
  private func makeRequest<Request: RequestProtocol>(with request: Request) -> URLRequest {
    var req: URLRequest

    // - リクエストパラメータの構築
    switch request.httpMethod {
    case .get:
      // GET の場合はクエリにパラメータ付与
      if let queryItems = request.parameters?.toStringValue.map({ URLQueryItem(name: $0.key, value: $0.value) }) {
        req = URLRequest(url: request.url.addQueries(queryItems)!)
      } else {
        req = URLRequest(url: request.url)
      }
    case .post, .put, .patch, .delete:
      // GET 以外の場合はボディにパラメータを付与
      req = URLRequest(url: request.url)
      req.httpBody = request.parameters?.toStringValue.toQueryString.data(using: .utf8)
    }

    // - HTTPメソッドを確定
    req.httpMethod = request.httpMethod.rawValue

    // - HTTPヘッダの設定
    let mergedHeaders = request.defalutHeaders.merging(request.headers ?? [:]) { $1 }
    for header in mergedHeaders {
      req.addValue(header.value, forHTTPHeaderField: header.key)
    }

    return req
  }
}

// MARK: - Extensions
private extension Dictionary where Key == String, Value == Any {
  /// value を String にダウンキャスト
  var toStringValue: [String: String] {
    return reduce([:]) { (result, param) -> [String: String] in
      var result = result

      switch param.value {
      case let string as String: result[param.key] = string
      case let int as Int: result[param.key] = String(int)
      case let double as Double: result[param.key] = String(double)
      case let float as Float: result[param.key] = String(float)
      case let bool as Bool: result[param.key] = String(bool)
      /* 必要になったら追加定義 */
      default: break
      }

      return result
    }
  }
}

private extension Dictionary where Key == String, Value == String {
  /// クエリ文字列へ変換
  var toQueryString: String {
    return enumerated().reduce("") { (result, tuple) in
      return result
        + tuple.element.key
        + "="
        + tuple.element.value
        + (count - 1 > tuple.offset ? "&" : "")
    }
  }
}
