import SwiftUI

struct AppLogo: View {
  let fontSize: CGFloat

  var body: some View {
    Text("HeyQiita")
      .font(.system(size: fontSize, weight: .ultraLight, design: .default))
  }
}

struct AppLogo_Previews: PreviewProvider {
  static var previews: some View {
    AppLogo(fontSize: 40)
      .previewLayout(.fixed(width: 390, height: 100))
  }
}
