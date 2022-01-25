import Combine

extension Publisher {
  /// 結果と用途に合わせて引数省略可能にした sink の拡張
  /// （デフォの sink が使いにくかったので）
  func sink(
    onReceivedValue: ((Self.Output) -> Void)? = nil,
    onFailure: ((Self.Failure) -> Void)? = nil,
    onFinished: (() -> Void)? = nil
  ) -> AnyCancellable {
    return sink(
      receiveCompletion: { result in
        switch result {
        case .finished: onFinished?()
        case .failure(let error): onFailure?(error)
        }
      },
      receiveValue: { value in
        onReceivedValue?(value)
      }
    )
  }
}
