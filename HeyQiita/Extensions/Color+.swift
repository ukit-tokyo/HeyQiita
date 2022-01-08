import SwiftUI

extension Color {
  // MARK: - Primary Color
  static func primary(_ level: Int) -> Color {
    return Color("Primary\(level)")
  }

  // MARK: - Label Color
  static let label = Color("Label")
  static let secondaryLabel = Color("SecondaryLabel")
  static let tertiaryLabel = Color("TertiaryLabel")
  static let quaternaryLabel = Color("QuaternaryLabel")
}
