//
//  NSLayoutDimension+.swift
//  FineDust
//
//  Created by Presto on 22/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

extension NSLayoutDimension {
  /// `constraint(equalToConstant:)` 메소드의 Helper.
  func equal(toConstant offset: CGFloat) -> NSLayoutConstraint {
    return constraint(equalToConstant: offset)
  }
}
