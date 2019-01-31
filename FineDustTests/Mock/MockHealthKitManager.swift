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
import UIKit

final class MockHealthKitManager: HealthKitServiceManagerType {

  var distance = 1000.0
  var stepCount = 2174.0
  
  
  func findHealthKitValue(startDate: Date,
                          endDate: Date,
                          quantityFor: HKUnit,
                          quantityTypeIdentifier: HKQuantityTypeIdentifier,
                          completion: @escaping (Double) -> Void) {
    switch quantityTypeIdentifier {
    case .distanceWalkingRunning:
      completion(1409.53)
    case .stepCount:
      completion(2314.0)
    default: 0
    }
  }
  
  func fetchDistanceValue(_ completion: @escaping (Double) -> Void) {
    completion(distance)
  }
  
  func fetchStepCountValue(_ completion: @escaping (Double) -> Void) {
    completion(stepCount)
  }
  
  func openHealth(_ viewController: UIViewController) {
    
  }
  
  func fetchHealthKitValue(label: UILabel, quantityTypeIdentifier: HKQuantityTypeIdentifier) {
    
  }
}

