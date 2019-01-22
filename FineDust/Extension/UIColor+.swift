//
//  UIColor+.swift
//  FineDust
//
//  Created by Presto on 21/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

extension UIColor {
  /// RGB 값으로 색상 만들기
  convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
    self.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
  }
  
  /// RGB 값이 같을 때 색상 만들기
  convenience init(rgb: CGFloat) {
    self.init(red: rgb, green: rgb, blue: rgb)
  }
  
  /// HEX 값으로 색상 만들기
  convenience init(red: Int, green: Int, blue: Int) {
    self.init(
      red: CGFloat(red) / 255,
      green: CGFloat(green) / 255,
      blue: CGFloat(blue) / 255,
      alpha: 1
    )
  }
  
  /// HEX 값이 같을 때 색상 만들기
  convenience init(rgb: Int) {
    self.init(red: (rgb >> 16) & 0xFF, green: (rgb >> 8) & 0xFF, blue: rgb & 0xFF
    )
  }
}
