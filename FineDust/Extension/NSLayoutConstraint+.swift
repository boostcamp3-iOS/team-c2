//
//  NSLayoutConstraint+.swift
//  FineDust
//
//  Created by Presto on 22/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
  func changeMultiplier(to value: CGFloat) -> NSLayoutConstraint {
    let constraint = NSLayoutConstraint(
      item: firstItem as Any,
      attribute: firstAttribute,
      relatedBy: relation,
      toItem: secondItem,
      attribute: secondAttribute,
      multiplier: value,
      constant: constant
    )
    constraint.priority = priority
    constraint.shouldBeArchived = shouldBeArchived
    constraint.identifier = identifier
    NSLayoutConstraint.deactivate([self])
    NSLayoutConstraint.activate([constraint])
    return constraint
  }
}
