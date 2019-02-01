//
//  HealthKitService.swift
//  FineDust
//
//  Created by 이재은 on 01/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

class HealthKitService: HealthKitServiceType {
  
  let healthKitManager: HealthKitManagerType? 
  
  init(healthKit: HealthKitManagerType) {
    self.healthKitManager = healthKit
  }

  func fetchStepCount(startDate: Date, endDate: Date, completion: @escaping (Double?) -> Void) {
        if startDate > endDate {
          completion(nil)
          return
        }
    
    healthKitManager?.findHealthKitValue(startDate: Date.start(),
                                         endDate: Date(),
                                         quantityFor: .count(),
                                         quantityTypeIdentifier: .stepCount,
                                         completion: completion)
  }
  
  func fetchDistance(startDate: Date, endDate: Date, completion: @escaping (Double?) -> Void) {
        if startDate > endDate {
          completion(nil)
          return
        }
    
    healthKitManager?.findHealthKitValue(startDate: Date.start(),
                                         endDate: Date(),
                                         quantityFor: .meter(),
                                    quantityTypeIdentifier: .distanceWalkingRunning,
                                         completion: completion)
  }
}
