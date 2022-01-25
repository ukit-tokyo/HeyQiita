public protocol RequestProtocol {
  associatedtype Response: Decodable

  var baseURL: String { get }
  var endpoint: String { get }
  var httpMethod: HTTPMethod { get }
  var version: String { get }
  var parameters: [String: Any]? { get }
  var headers: [String: String]? { get }
}

extension RequestProtocol {
  public var baseURL: String { "https://qiita.com/api" }
  public var version: String { "/v2" }
  public var parameters: [String: Any]? { nil }
  public var headers: [String: String]? { nil }

  var url: URL { URL(string: "\(baseURL)\(version)\(endpoint)")! }
  var defalutHeaders: [String: String] { ["Content-Type": "application/json"] }
}

public enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case patch = "PATCH"
  case delete = "DELETE"
}
