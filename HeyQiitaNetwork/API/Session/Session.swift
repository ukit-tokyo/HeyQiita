import Combine

/// 共通 API 実行クラス
public struct Session {
  public static let shared = Session()

  private init() {}

  public func send<Request: RequestProtocol, Response>(_ request: Request)
    -> AnyPublisher<Response, SessionError> where Request.Response == Response
  {
    let req = makeRequest(with: request)
    let decorder = JSONDecoder()
    decorder.keyDecodingStrategy = .convertFromSnakeCase

    return URLSession.shared.dataTaskPublisher(for: req)
      .timeout(.seconds(10), scheduler: DispatchQueue.main)
      .retry(2)
      .tryMap { (data, response) in
        // print network results
        dump(with: data, request: request, response: response)

        guard let response = response as? HTTPURLResponse,
              200 ..< 300 ~= response.statusCode else {
          throw SessionError(with: data, decoder: decorder)
        }
        return data
      }
      .decode(type: Response.self, decoder: decorder)
      .mapError { error in
        switch error {
        case let error as SessionError:
          return error
        case _ as DecodingError:
          return SessionError.decodingFailure
        default:
          return SessionError.unknown
        }
      }
      .receive(on: DispatchQueue.main)
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
      req.httpBody = try? JSONSerialization.data(withJSONObject: request.parameters ?? [:])
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

  private func dump<Request: RequestProtocol>(with data: Data, request: Request, response: URLResponse) {
    #if DEBUG || STUB
    let dump: String = """

    ====✅ API RESULT ✅=====
    path: \(request.endpoint)
    param: \(request.parameters ?? [:])
    header: \(request.headers ?? [:])
    status: \((response as? HTTPURLResponse)?.statusCode ?? 0)
    response: \(String(data: data, encoding: .utf8) ?? "")
    =========================

    """
    print(dump)
    #endif
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
      default: fatalError("↑ダウンキャスト定義を追加してー")
      }

      return result
    }
  }
}
