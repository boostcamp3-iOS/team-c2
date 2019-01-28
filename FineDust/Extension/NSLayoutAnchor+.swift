//
//  NSLayoutAnchor+.swift
//  FineDust
//
//  Created by Presto on 22/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

extension NSLayoutAnchor {
  /// `constraint(equalTo:constant:)` 메소드의 Helper.
  @objc func equal(to anchor: NSLayoutAnchor, offset: CGFloat = 0) -> NSLayoutConstraint {
    return constraint(equalTo: anchor, constant: offset)
  }
  /// `constraint(greaterThanOrEqualTo:constant:)` 메소드의 Helper.
  @objc func greaterThanOrEqual(
    to anchor: NSLayoutAnchor,
    offset: CGFloat = 0
  ) -> NSLayoutConstraint {
    return constraint(greaterThanOrEqualTo: anchor, constant: offset)
  }
  /// `constraint(lessThanOrEqualTo:constant:)` 메소드의 Helper.
  @objc func lessThanOrEqual(
    to anchor: NSLayoutAnchor,
    offset: CGFloat = 0
  ) -> NSLayoutConstraint {
    return constraint(lessThanOrEqualTo: anchor, constant: offset)
  }
}
