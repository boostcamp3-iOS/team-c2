//
//  RatioGraphViewDelegate.swift
//  FineDust
//
//  Created by Presto on 06/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation
import UIKit

/// Ratio Graph View Data Source.
protocol RatioGraphViewDataSource: class {
  
  /// 전체 흡입량에 대한 부분의 비율.
  var intakeRatio: CGFloat { get }
}
