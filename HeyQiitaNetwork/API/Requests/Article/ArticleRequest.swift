public struct ArticleRequest: RequestProtocol {
  public typealias Response = [Article]

  public var endpoint: String { "/items" }
  public var httpMethod: HTTPMethod { .get }

  public init() {}
}

public struct Article: Decodable {
  public let renderedBody: String
  // TODO
}
