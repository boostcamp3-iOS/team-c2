//
//  FloatingPoint+.swift
//  FineDust
//
//  Created by Presto on 21/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

extension FloatingPoint {
  
  var canBecomeMultiplier: Bool {
    return !(isInfinite || isZero || isNaN)
  }
}
