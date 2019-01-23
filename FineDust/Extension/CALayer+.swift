//
//  CALayer+.swift
//  FineDust
//
//  Created by Presto on 22/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

extension CALayer {
  func setBorder(
    color borderColor: UIColor,
    width borderWidth: CGFloat = 1,
    radius cornerRadius: CGFloat = 0
  ) {
    masksToBounds = true
    self.borderColor = borderColor.cgColor
    self.borderWidth = borderWidth
    self.cornerRadius = cornerRadius
  }
}
