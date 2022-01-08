import SwiftUI

struct TextButton: View {
  let title: String
  let fontSize: CGFloat
  let action: () -> ()

  init(
    title: String,
    fontSize: CGFloat = 20,
    action: @escaping () -> ()
  ) {
    self.title = title
    self.fontSize = fontSize
    self.action = action
  }

  var body: some View {
    Button(title, action: action)
      .font(.system(size: fontSize, weight: .regular, design: .default))
      .foregroundColor(.label)
      .padding(10)
  }
}

struct TextButton_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      TextButton(title: "Button", action: {})
        .previewLayout(.fixed(width: 390, height: 100))
      TextButton(title: "Button", fontSize: 40, action: {})
        .previewLayout(.fixed(width: 390, height: 100))
    }
  }
}
