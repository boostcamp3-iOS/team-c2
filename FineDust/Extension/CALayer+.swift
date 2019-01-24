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
  
  func applySketchShadow(
    color: UIColor = .black,
    alpha: Float = 0.5,
    x: CGFloat = 0,
    y: CGFloat = 2,
    blur: CGFloat = 4,
    spread: CGFloat = 0
  ) {
    shadowColor = color.cgColor
    shadowOpacity = alpha
    shadowOffset = CGSize(width: x, height: y)
    shadowRadius = blur / 2.0
    if spread == 0 {
      shadowPath = nil
    } else {
      let dx = -spread
      let rect = bounds.insetBy(dx: dx, dy: dx)
      shadowPath = UIBezierPath(rect: rect).cgPath
    }
  }
  
  func applyGradient(
    colors: [Any],
    locations: [NSNumber],
    startPoint: CGPoint = .init(x: 0.5, y: 0),
    endPoint: CGPoint = .init(x: 0.5, y: 1)
  ) {
    let gradient = CAGradientLayer()
    gradient.frame = bounds
    gradient.startPoint = startPoint
    gradient.endPoint = endPoint
    gradient.colors = colors
    gradient.locations = locations
    mask = gradient
  }
}
