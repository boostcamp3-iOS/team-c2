//
//  Double+.swift
//  FineDust
//
//  Created by 이재은 on 28/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

extension Double {
  /// kilometer 변환하기.
  var kilometer: Double {
    if self < 1000 {
      return self
    } else {
      return self / 1000
    }
  }
}
