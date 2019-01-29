//
//  UIView+NSLayoutAnchor.swift
//  FineDust
//
//  Created by Presto on 22/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

extension UIView {
  /// anchor 정보를 담는 구조체.
  struct Anchor {
    let view: UIView
    let top: NSLayoutYAxisAnchor
    let bottom: NSLayoutYAxisAnchor
    let leading: NSLayoutXAxisAnchor
    let trailing: NSLayoutXAxisAnchor
    let centerX: NSLayoutXAxisAnchor
    let centerY: NSLayoutYAxisAnchor
    let width: NSLayoutDimension
    let height: NSLayoutDimension
  }
  
  /// `UIView`의 `Anchor` 정보.
  var anchor: Anchor {
    return Anchor(
      view: self,
      top: topAnchor,
      bottom: bottomAnchor,
      leading: leadingAnchor,
      trailing: trailingAnchor,
      centerX: centerXAnchor,
      centerY: centerYAnchor,
      width: widthAnchor,
      height: heightAnchor
    )
  }
}
