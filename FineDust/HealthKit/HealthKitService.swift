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
                                         quantityFor: .count(),
                                         quantityTypeIdentifier: .stepCount
    ) { value, error in
      if let error = error {
        completion(nil, error)
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
                                         quantityFor: .meter(),
                                         quantityTypeIdentifier: .distanceWalkingRunning
    ) { value, error in
      if let error = error {
        completion(nil, error)
        return
      }
      if let value = value {
        completion(value, nil)
      }
    }
  }
}
