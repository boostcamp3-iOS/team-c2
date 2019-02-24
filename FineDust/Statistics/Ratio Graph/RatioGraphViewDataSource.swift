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
  var intakeRatio: Double { get }
  
  /// 일주일간 총 흡입량.
  var totalIntake: Int { get }
  
  /// 오늘의 흡입량.
  var todayIntake: Int { get }
}
