//
//  IntakeData.swift
//  FineDust
//
//  Created by Presto on 23/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// 흡입량 데이터.
struct IntakeData {
  
  /// 일주일 미세먼지 흡입량.
  var weekFineDust: [Int] = [Int](repeating: 1, count: 7)
  
  /// 일주일 초미세먼지 흡입량.
  var weekUltrafineDust: [Int] = [Int](repeating: 1, count: 7)
  
  /// 오늘 미세먼지 흡입량.
  var todayFineDust: Int = 1
  
  /// 오늘 초미세먼지 흡입량.
  var todayUltrafineDust: Int = 1
  
  /// 초기화.
  mutating func reset(_ intakeData: IntakeData) {
    self = intakeData
  }
}
