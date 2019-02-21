//
//  FloatingPoint+.swift
//  FineDust
//
//  Created by Presto on 21/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

extension FloatingPoint {
  
  /// Multiplier로 사용할 수 있는가.
  ///
  /// Multiplier는 0이 아니고, 숫자여야 한다.
  var canBecomeMultiplier: Bool {
    return !(isInfinite || isZero || isNaN)
  }
}
