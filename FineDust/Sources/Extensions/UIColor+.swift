//
//  UIColor+.swift
//  FineDust
//
//  Created by Presto on 21/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

extension UIColor {
  
  convenience init(rgb: CGFloat, alpha: CGFloat = 1) {
    self.init(red: rgb, green: rgb, blue: rgb, alpha: alpha)
  }
  
  convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1) {
    self.init(red: CGFloat(red) / 255,
              green: CGFloat(green) / 255,
              blue: CGFloat(blue) / 255,
              alpha: alpha)
  }
  
  convenience init(rgb: Int, alpha: CGFloat = 1) {
    self.init(red: (rgb >> 16) & 0xFF, green: (rgb >> 8) & 0xFF, blue: rgb & 0xFF, alpha: alpha)
  }
}
