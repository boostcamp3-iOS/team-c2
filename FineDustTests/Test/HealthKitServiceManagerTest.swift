//
//  HealthKitServiceManagerTest.swift
//  FineDustTests
//
//  Created by 이재은 on 30/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import XCTest
import HealthKit

class HealthKitServiceManagerTest: XCTestCase {
  
//  var healthKitServiceManager = HealthKitServiceManager()
  
  var mockHealthKitManager = MockHealthKitManager()
  
  var expectedResult = 0.0
  
  override func setUp() {
    expectedResult = 0.0
  }
  
  override func tearDown() {
    
  }
  
  func testCheckStepCount() {
    mockHealthKitManager.findHealthKitValue(startDate: Date(),
                                            endDate: Date(),
                                            quantityFor: HKUnit.count(),
                                            quantityTypeIdentifier: HKQuantityTypeIdentifier.stepCount
    ) { (value) -> Void in
      self.expectedResult = value
    }
    XCTAssertEqual(2314.0, expectedResult, "stepCount should be 2314.0")
  }
  
  func testChecktDistance() {
    mockHealthKitManager.findHealthKitValue(startDate: Date(),
                                            endDate: Date(),
                                            quantityFor: HKUnit.meter(),
                                            quantityTypeIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning
    ) { (value) -> Void in
      self.expectedResult = value
    }
    XCTAssertEqual(1409.53, expectedResult, "distance should be 1409.53")
  }
  
  func testCheckQuantityType() {
    mockHealthKitManager.findHealthKitValue(startDate: Date(),
                                            endDate: Date(),
                                            quantityFor: HKUnit.count(),
                                            quantityTypeIdentifier: HKQuantityTypeIdentifier.pushCount
    ) { (value) -> Void in
      self.expectedResult = value
    }
    XCTAssertEqual(0, expectedResult, "stepCount should be 0")
  }
}
