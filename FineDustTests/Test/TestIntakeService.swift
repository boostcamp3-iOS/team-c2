//
//  IntakeServiceTest.swift
//  FineDustTests
//
//  Created by Presto on 04/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import XCTest
import Foundation

class TestIntakeService: XCTestCase {
  
  let mockDustInfoService = MockDustInfoService()
  
  let mockHealthKitService = MockHealthKitService()
  
  let mockCoreDataService = MockCoreDataService()
  
  var intakeService: IntakeService!
  
  override func setUp() {
    intakeService = IntakeService(healthKitService: mockHealthKitService, dustInfoService: mockDustInfoService, coreDataService: mockCoreDataService)
  }
  
  func test_requestTodayIntake() {
    mockDustInfoService.fineDustHourlyValue = DummyDustInfoService.fineDustHourlyValue
    mockDustInfoService.ultrafineDustHourlyValue = DummyDustInfoService.ultrafineDustHourlyValue
    mockHealthKitService.hourlyDistance = DummyHealthKitService.hourlyDistance
    mockDustInfoService.error = nil
    mockHealthKitService.error = nil
    let expect = expectation(description: "test")
    intakeService.requestTodayIntake { fineDust, ultrafineDust, error in
      XCTAssertNotNil(fineDust)
      XCTAssertNotNil(ultrafineDust)
      XCTAssertNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_requestIntakesInWeek() {
    mockDustInfoService.fineDustHourlyValuePerDate = DummyDustInfoService.fineDustHourlyValuePerDate
    mockDustInfoService.ultrafineDustHourlyValuePerDate = DummyDustInfoService.ultrafineDustHourlyValuePerDate
    mockDustInfoService.error = nil
    mockHealthKitService.hourlyDistancePerDate = DummyHealthKitService.hourlyDistancePerDate
    mockHealthKitService.error = nil
    //mockCoreDataService.
    let expect = expectation(description: "test")
    intakeService.requestIntakesInWeek { fineDusts, ultrafineDusts, error in
      XCTAssertNil(fineDusts)
      XCTAssertNil(ultrafineDusts)
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_requestTodayIntake_error() {
    mockDustInfoService.error = DustError.accessDenied
    mockHealthKitService.error = NSError(domain: "healthKitError", code: 0, userInfo: nil)
    let expect = expectation(description: "test")
    intakeService.requestTodayIntake { fineDust, ultrafineDust, error in
      XCTAssertNil(fineDust)
      XCTAssertNil(ultrafineDust)
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_requestIntakesInWeek_error() {
    mockDustInfoService.error = DustError.accessDenied
    mockHealthKitService.error = NSError(domain: "healthKitError", code: 0, userInfo: nil)
    let expect = expectation(description: "test")
    intakeService.requestIntakesInWeek { fineDusts, ultrafineDusts, error in
      XCTAssertNil(fineDusts)
      XCTAssertNil(ultrafineDusts)
      XCTAssertNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
}
