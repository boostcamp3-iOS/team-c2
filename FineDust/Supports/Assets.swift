// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSImage
  internal typealias AssetColorTypeAlias = NSColor
  internal typealias AssetImageTypeAlias = NSImage
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
  internal typealias AssetColorTypeAlias = UIColor
  internal typealias AssetImageTypeAlias = UIImage
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let black45 = ColorAsset(name: "black45")
  internal static let graph1 = ColorAsset(name: "graph1")
  internal static let graph2 = ColorAsset(name: "graph2")
  internal static let graphBorder = ColorAsset(name: "graphBorder")
  internal static let graphToday = ColorAsset(name: "graphToday")
  internal static let tillandsia = ImageAsset(name: "Tillandsia")
  internal static let ventilation = ImageAsset(name: "Ventilation")
  internal static let childrenSteps = ImageAsset(name: "childrenSteps")
  internal static let info1 = ImageAsset(name: "info1")
  internal static let mist = ImageAsset(name: "mist")
  internal static let nose = ImageAsset(name: "nose")
  internal static let oldSteps = ImageAsset(name: "oldSteps")
  internal static let outside = ImageAsset(name: "outside")
  internal static let redheart = ImageAsset(name: "redheart")
  internal static let seoul = ImageAsset(name: "seoul")
  internal static let sevenSteps = ImageAsset(name: "sevenSteps")
  internal static let starOutline = ImageAsset(name: "star-outline")
  internal static let steps = ImageAsset(name: "steps")
  internal static let studentSteps = ImageAsset(name: "studentSteps")
  internal static let vitaminB = ImageAsset(name: "vitaminB")
  internal static let yellowStar = ImageAsset(name: "yellow-star")
  internal static let backButton = ImageAsset(name: "backButton")
  internal static let barChartTabIcon = ImageAsset(name: "barChartTabIcon")
  internal static let distance = ImageAsset(name: "distance")
  internal static let dust1 = ImageAsset(name: "dust_1")
  internal static let dust2 = ImageAsset(name: "dust_2")
  internal static let dust3 = ImageAsset(name: "dust_3")
  internal static let dust4 = ImageAsset(name: "dust_4")
  internal static let dust5 = ImageAsset(name: "dust_5")
  internal static let dustIcon1 = ImageAsset(name: "dust_icon_1")
  internal static let dustIcon2 = ImageAsset(name: "dust_icon_2")
  internal static let dustIcon3 = ImageAsset(name: "dust_icon_3")
  internal static let dustIcon4 = ImageAsset(name: "dust_icon_4")
  internal static let dustIcon5 = ImageAsset(name: "dust_icon_5")
  internal static let dusts = ImageAsset(name: "dusts")
  internal static let heart = ImageAsset(name: "heart")
  internal static let infoTabIcon = ImageAsset(name: "infoTabIcon")
  internal static let mainTabIcon = ImageAsset(name: "mainTabIcon")
  internal static let sort = ImageAsset(name: "sort")
  internal static let speechBubble1 = ImageAsset(name: "speechBubble1")
  internal static let speechBubble2 = ImageAsset(name: "speechBubble2")
  internal static let walking = ImageAsset(name: "walking")
  internal static let widgetBackground = ImageAsset(name: "widget_background")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal struct ColorAsset {
  internal fileprivate(set) var name: String

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  internal var color: AssetColorTypeAlias {
    return AssetColorTypeAlias(asset: self)
  }
}

internal extension AssetColorTypeAlias {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  convenience init!(asset: ColorAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal struct DataAsset {
  internal fileprivate(set) var name: String

  #if os(iOS) || os(tvOS) || os(OSX)
  @available(iOS 9.0, tvOS 9.0, OSX 10.11, *)
  internal var data: NSDataAsset {
    return NSDataAsset(asset: self)
  }
  #endif
}

#if os(iOS) || os(tvOS) || os(OSX)
@available(iOS 9.0, tvOS 9.0, OSX 10.11, *)
internal extension NSDataAsset {
  convenience init!(asset: DataAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(name: asset.name, bundle: bundle)
    #elseif os(OSX)
    self.init(name: NSDataAsset.Name(asset.name), bundle: bundle)
    #endif
  }
}
#endif

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  internal var image: AssetImageTypeAlias {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    let image = AssetImageTypeAlias(named: name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = AssetImageTypeAlias(named: name)
    #endif
    guard let result = image else { fatalError("Unable to load image named \(name).") }
    return result
  }
}

internal extension AssetImageTypeAlias {
  @available(iOS 1.0, tvOS 1.0, watchOS 1.0, *)
  @available(OSX, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init!(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = Bundle(for: BundleToken.self)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

private final class BundleToken {}
