import SwiftUI

struct AppButton: View {
  private let title: String
  private let fontSize: CGFloat
  private let height: CGFloat
  private let action: () -> ()

  init(
    title: String, fontSize: CGFloat = 20,
    action: @escaping () -> ()
  ) {
    self.title = title
    self.fontSize = fontSize
    self.height = fontSize + 32.0
    self.action = action
  }

  var body: some View {
    Button(
      action: action,
      label: {
        Text(title)
          .font(.system(size: fontSize, weight: .regular, design: .default))
          .foregroundColor(.primary(500))
          .padding()
          .cornerRadius(height/2)
          .frame(width: .infinity, height: height, alignment: .center)
          .overlay(
            RoundedRectangle(cornerRadius: height/2)
              .stroke(Color.primary(500), lineWidth: 2)
          )
      })
  }
}

#if DEBUG || STUB
struct AppButton_Previews: PreviewProvider {
  static let view: some View = AppButton(title: "Button", action: {})
    .previewLayout(.fixed(width: 390, height: 100))

  static var previews: some View {
    Group {
      view.preferredColorScheme(.dark)
      view.preferredColorScheme(.light)
    }
  }
}
#endif
