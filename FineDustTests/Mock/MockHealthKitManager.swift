//
//  MockHealthKitManager.swift
//  FineDustTests
//
//  Created by 이재은 on 03/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import Foundation
import HealthKit

final class MockHealthKitManager: HealthKitManagerType {
  
  var error: HealthKitError?
  var stepCount = 2314.0
  var distance = 1409.53
  var hourInteger = 1
  
  var authorizationStatus: (HKAuthorizationStatus, HKAuthorizationStatus) {
    return (.notDetermined, .notDetermined)
  }
  
  func findHealthKitValue(startDate: Date,
                          endDate: Date,
                          hourInterval: Int,
                          quantityFor: HKUnit,
                          identifier: HKQuantityTypeIdentifier,
                          completion: @escaping (Double?, Int?, Error?) -> Void) {
    if let error = self.error {
      switch identifier {
      case .distanceWalkingRunning:
        completion(nil, nil, error)
      case .stepCount:
        completion(nil, nil, error)
      default:
        break
      }
      return
    }
    
    if hourInterval == 1 {
      for value in DummyHealthKitService.hourlyDistance {
        let hour = value.key
        let quantityValue = value.value
        completion(Double(quantityValue), hour.rawValue, nil)
      }
    } else {
      switch identifier {
      case .distanceWalkingRunning:
        completion(distance, hourInteger, error)
      case .stepCount:
        completion(stepCount, hourInteger, error)
      default:
        break
      }
    }
  }

  func requestAuthorization() { }
}
