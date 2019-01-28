//
//  MockHealthKitManager.swift
//  FineDustTests
//
//  Created by Presto on 28/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

// 4. Mock 만듦
@testable import FineDust

import Foundation
import HealthKit

final class MockHealthKitManager: HealthKitManagerType {
  
  func findHealthKitValue(startDate: Date,
                          endDate: Date,
                          quantityFor: HKUnit,
                          quantityTypeIdentifier: HKQuantityTypeIdentifier,
                          completion: @escaping (Double) -> Void) {
    completion(5)
  }
  
  func fetchDistanceValue(_ completion: @escaping (Double) -> Void) {
    completion(1000)
  }
  
  func fetchStepCountValue(_ completion: @escaping (Double) -> Void) {
    completion(2174)
  }
}
