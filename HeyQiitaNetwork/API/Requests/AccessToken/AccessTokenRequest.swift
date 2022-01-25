public struct AccessToken: Decodable {
  public let token: String
}

public struct AccessTokenRequest: RequestProtocol {
  public struct Parameter {
    let clientID: String
    let clientSecret: String
    let code: String

    public init(clientID: String, clientSecret: String, code: String) {
      self.clientID = clientID
      self.clientSecret = clientSecret
      self.code = code
    }
  }

  public typealias Response = AccessToken

  public var endpoint: String { "/access_tokens" }
  public var httpMethod: HTTPMethod { .post }
  public var parameters: [String: Any]? {
    [
      "client_id": param.clientID,
      "client_secret": param.clientSecret,
      "code": param.code,
    ]
  }

  private let param: Parameter

  public init(_ param: Parameter) {
    self.param = param
  }
}
