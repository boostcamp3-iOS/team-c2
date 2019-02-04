//
//  HealthKitServiceTest.swift
//  FineDustTests
//
//  Created by 이재은 on 01/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import XCTest
import Foundation

class HealthKitServiceTest: XCTestCase {
  
  var healthKitService: HealthKitServiceType?
  let mockHealthKitManager = MockHealthKitManager()
  
  override func setUp() {
    healthKitService = HealthKitService(healthKit: mockHealthKitManager)
    
  }
  
  func testStepCount() {
//    let result = healthKitService?.fetchStepCount(startDate: Date, endDate: Date) { (Double) in
      completion(Double)
    })
    
    XCTAssertEqual(result, mockHealthKitManager.stepCount)
  }
}
