// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

#if os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIColor
  typealias Color = UIColor
#elseif os(OSX)
  import AppKit.NSColor
  typealias Color = NSColor
#endif

extension Color {
  convenience init(rgbaValue: UInt32) {
    let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
    let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
    let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
    let alpha = CGFloat((rgbaValue      ) & 0xff) / 255.0

    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
}

// swiftlint:disable file_length
// swiftlint:disable type_body_length
enum ColorName {
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f2f2f3"></span>
  /// Alpha: 100% <br/> (0xf2f2f3ff)
  case background
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#2e3134"></span>
  /// Alpha: 100% <br/> (0x2e3134ff)
  case bar
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#257f17"></span>
  /// Alpha: 100% <br/> (0x257f17ff)
  case buttonTint
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#282828"></span>
  /// Alpha: 100% <br/> (0x282828ff)
  case darkText
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ecedee"></span>
  /// Alpha: 100% <br/> (0xecedeeff)
  case detailBackground
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#696e72"></span>
  /// Alpha: 100% <br/> (0x696e72ff)
  case lightText

  var rgbaValue: UInt32 {
    switch self {
    case .background: return 0xf2f2f3ff
    case .bar: return 0x2e3134ff
    case .buttonTint: return 0x257f17ff
    case .darkText: return 0x282828ff
    case .detailBackground: return 0xecedeeff
    case .lightText: return 0x696e72ff
    }
  }

  var color: Color {
    return Color(named: self)
  }
}
// swiftlint:enable type_body_length

extension Color {
  convenience init(named name: ColorName) {
    self.init(rgbaValue: name.rgbaValue)
  }
}
