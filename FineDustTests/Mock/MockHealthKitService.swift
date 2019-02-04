//
//  MockHealthKitService.swift
//  FineDustTests
//
//  Created by Presto on 04/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import Foundation

class MockHealthKitService: HealthKitServiceType {
  
  var error: Error?
  
  var distance: Double?
  
  var stepCount: Double?
  
  func fetchTodayDistance(completion: @escaping (Double?, Error?) -> Void) {
    completion(distance, error)
  }
  
  func fetchTodayStepCount(completion: @escaping (Double?, Error?) -> Void) {
    completion(stepCount, error)
  }
}
