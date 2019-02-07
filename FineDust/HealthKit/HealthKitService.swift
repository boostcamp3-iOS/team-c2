//
//  HealthKitService.swift
//  FineDust
//
//  Created by 이재은 on 01/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// HealthKit 서비스를 구현하는 클래스
final class HealthKitService: HealthKitServiceType {
  
  let healthKitManager: HealthKitManagerType? 
  
  init(healthKit: HealthKitManagerType) {
    self.healthKitManager = healthKit
  }
  
  /// 오늘 걸음 수 가져오는 함수
  func fetchTodayStepCount(completion: @escaping (Double?, Error?) -> Void) {
    
    healthKitManager?.findHealthKitValue(startDate: Date.start(),
                                         endDate: Date(),
                                         hourInterval: 24,
                                         quantityFor: .count(),
                                         quantityTypeIdentifier: .stepCount
    ) { value, error in
      if let error = error {
        completion(0, error)
        return
      }
      if let value = value {
        completion(value, nil)
      }
    }
  }
  
  /// 오늘 걸은 거리 가져오는 함수
  func fetchTodayDistance(completion: @escaping (Double?, Error?) -> Void) {
    healthKitManager?.findHealthKitValue(startDate: Date.start(),
                                         endDate: Date(),
                                         hourInterval: 24,
                                         quantityFor: .meter(),
                                         quantityTypeIdentifier: .distanceWalkingRunning
    ) { value, error in
      if let error = error {
        completion(0, error)
        return
      }
      if let value = value {
        completion(value, nil)
      }
    }
  }
  
  /// 날짜 범위가 주어질 때 그 사이에 시간당 걸음거리를 fetch.
  func fetchDistancePerHour(from startDate: Date, to endDate: Date) {
    
  }
}
