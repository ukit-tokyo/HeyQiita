import HeyQiitaNetwork
import Combine

final class API {
  static let shared = API()
  private var cancellables: Set<AnyCancellable> = []

  private init() {}

  /// Core 専用 API ラッパー
  func send<Request: RequestProtocol, Response>(_ request: Request)
    -> Future<Response, SessionError> where Request.Response == Response
  {
    Future { promise in
      Session.shared
        .send(request)
        .sink(
          onReceivedValue: {
            promise(.success($0))
          },
          onFailure: { error in
            promise(.failure(error))
            RootViewModel.shared.catchAPIError(error)
          },
          onFinished: {}
        )
        .store(in: &self.cancellables)
    }
  }
}
