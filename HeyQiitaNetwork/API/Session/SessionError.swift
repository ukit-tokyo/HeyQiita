public struct SessionError: Error {
  public struct Body: Decodable {
    public let message: String
    public let type: String
  }

  public let body: Body?

  init(with data: Data, decoder: JSONDecoder) {
    body = try? decoder.decode(Body.self, from: data)
  }

  init(with body: Body) {
    self.body = body
  }

  /// JSONデコードエラー
  static var decodingFailure: SessionError {
    SessionError(with: Body(message: "JSON Decoding Failed", type: "decoding_Failed"))
  }

  /// 不明エラー
  static var unknown: SessionError {
    SessionError(with: Body(message: "Unknown Error", type: "unknow_error"))
  }
}
