//
//  HealthKitServiceType.swift
//  FineDust
//
//  Created by 이재은 on 01/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation
import HealthKit

/// HealthKit Service Type.
protocol HealthKitServiceType: class {
  /// 오늘 걸음 수 값 fetch.
  func fetchTodayStepCount(completion: @escaping (Double?, Error?) -> Void)
  
  /// 오늘 걸은 거리 값 fetch.
  func fetchTodayDistance(completion: @escaping (Double?, Error?) -> Void)
  
  /// 날짜 범위가 주어질 때 그 사이에 시간당 걸음거리를 fetch.
  func fetchDistancePerHour(from startDate: Date, to endDate: Date)
}
