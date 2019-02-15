//
//  UIView+.swift
//  FineDust
//
//  Created by Presto on 21/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

extension UIView {
  
  /// `UIView` instantiate.
  static func instantiate(fromXib name: String) -> UIView? {
    return UINib(nibName: name, bundle: nil)
      .instantiate(withOwner: nil, options: nil).first as? UIView
  }
}
