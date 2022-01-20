import HeyQiitaNetwork
import Combine

public final class RootViewModel: ObservableObject {
  public static let shared = RootViewModel()

  @Published public var alert: APIErrorAlert

  private init() {
    alert = APIErrorAlert()
  }

  func catchAPIError(_ error: SessionError) {
    alert.update(show: true, message: error.body?.message)
  }

  public func resetAlert() {
    alert.update(show: false, message: nil)
  }
}

extension RootViewModel {
  public class APIErrorAlert {
    @Published public var isShown: Bool = false
    public private(set) var message: String?

    func update(show: Bool, message: String?) {
      self.message = message
      self.isShown = show
    }
  }
}
