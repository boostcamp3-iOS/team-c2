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
  
  var isAuthorized: Bool { get }
  
  var isDetermined: Bool { get }
  
  /// 오늘 걸음 수 값 fetch.
  func requestTodayStepCount(completion: @escaping (Double?, Error?) -> Void)
  
  /// 오늘 걸은 거리 값 fetch.
  func requestTodayDistance(completion: @escaping (Double?, Error?) -> Void)
  
  /// 오늘 시간당 걸음거리를 HourIntakePair로 리턴하는 함수.
  func requestTodayDistancePerHour(completion: @escaping (HourIntakePair?) -> Void)
  
  /// 날짜 범위가 주어질 때 해당 날짜에 1시간당 걸음거리를 DateHourIntakePair로 리턴하는 함수.
  func requestDistancePerHour(from startDate: Date,
                              to endDate: Date,
                              completion: @escaping (DateHourIntakePair?) -> Void)
}
