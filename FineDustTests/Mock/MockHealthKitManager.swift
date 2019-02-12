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
  
  var error: Error?
  var stepCount = 2314.0
  var distance = 1409.53
  var hourInteger = 1
  
  func findHealthKitValue(startDate: Date,
                          endDate: Date,
                          hourInterval: Int,
                          quantityFor: HKUnit,
                          quantityTypeIdentifier: HKQuantityTypeIdentifier,
                          completion: @escaping (Double?, Int?, Error?) -> Void) {
    switch quantityTypeIdentifier {
    case .distanceWalkingRunning:
      completion(distance, hourInteger, error)
    case .stepCount:
      completion(stepCount, hourInteger, error)
    default:
      break
    }
  }

  func requestAuthorization() { }
}
