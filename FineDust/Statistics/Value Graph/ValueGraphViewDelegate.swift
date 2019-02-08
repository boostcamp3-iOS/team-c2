//
//  ValueGraphViewDelegate.swift
//  FineDust
//
//  Created by Presto on 06/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation
import UIKit

/// Value Graph View Delegate.
protocol ValueGraphViewDelegate: class {

  /// 오늘로부터 7일간의 미세먼지 흡입량.
  var intakeAmounts: [CGFloat] { get }
}
