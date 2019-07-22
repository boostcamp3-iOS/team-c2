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
    mockHealthKitService.isAuthorized = true
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
  
  func test_requestIntakesInWeek_full() {
    mockDustInfoService.fineDustHourlyValuePerDate = DummyDustInfoService.fineDustHourlyValuePerDate
    mockDustInfoService.ultrafineDustHourlyValuePerDate = DummyDustInfoService.ultrafineDustHourlyValuePerDate
    mockDustInfoService.error = nil
    mockHealthKitService.hourlyDistancePerDate = DummyHealthKitService.hourlyDistancePerDate
    mockHealthKitService.error = nil
    mockCoreDataService.coreDataIntakePerDate = DummyCoreDataService.intakePerDateFull
    mockCoreDataService.error = nil
    let expect = expectation(description: "test")
    intakeService.requestIntakesInWeek { fineDusts, ultrafineDusts, error in
      XCTAssertNotNil(fineDusts)
      XCTAssertNotNil(ultrafineDusts)
      XCTAssertNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_requestIntakesInWeek_half() {
    mockDustInfoService.fineDustHourlyValuePerDate = DummyDustInfoService.fineDustHourlyValuePerDate
    mockDustInfoService.ultrafineDustHourlyValuePerDate = DummyDustInfoService.ultrafineDustHourlyValuePerDate
    mockDustInfoService.error = nil
    mockHealthKitService.hourlyDistancePerDate = DummyHealthKitService.hourlyDistancePerDate
    mockHealthKitService.isAuthorized = true
    mockHealthKitService.error = nil
    mockCoreDataService.coreDataIntakePerDate = DummyCoreDataService.intakePerDateHalf
    mockCoreDataService.error = nil
    let expect = expectation(description: "test")
    intakeService.requestIntakesInWeek { fineDusts, ultrafineDusts, error in
      XCTAssertNotNil(fineDusts)
      XCTAssertNotNil(ultrafineDusts)
      XCTAssertNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_requestTodayIntake_error_dust() {
    mockDustInfoService.error = DustAPIError.accessDenied
    let expect = expectation(description: "test")
    intakeService.requestTodayIntake { fineDust, ultrafineDust, error in
      XCTAssertNil(fineDust)
      XCTAssertNil(ultrafineDust)
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_requestTodayIntake_error_noHealthKitPermission() {
    let expect = expectation(description: "test")
    mockDustInfoService.fineDustHourlyValue = DummyDustInfoService.fineDustHourlyValue
    mockDustInfoService.ultrafineDustHourlyValue = DummyDustInfoService.ultrafineDustHourlyValue
    mockHealthKitService.hourlyDistance = DummyHealthKitService.hourlyDistance
    mockDustInfoService.error = nil
    mockHealthKitService.isAuthorized = false
    mockHealthKitService.error = nil
    intakeService.requestTodayIntake { fineDust, ultrafineDust, error in
      XCTAssertNil(fineDust)
      XCTAssertNil(ultrafineDust)
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_requestIntakesInWeek_error_coreData() {
    mockDustInfoService.error = nil
    mockCoreDataService.error = NSError(domain: "coreDataError", code: 0, userInfo: nil)
    let expect = expectation(description: "test")
    intakeService.requestIntakesInWeek { fineDusts, ultrafineDusts, error in
      XCTAssertNil(fineDusts)
      XCTAssertNil(ultrafineDusts)
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_requestIntakesInWeek_error_dust() {
    mockDustInfoService.error = DustAPIError.accessDenied
    mockCoreDataService.coreDataIntakePerDate = DummyCoreDataService.intakePerDateHalf
    mockCoreDataService.error = nil
    let expect = expectation(description: "test")
    intakeService.requestIntakesInWeek { fineDusts, ultrafineDusts, error in
      XCTAssertNil(fineDusts)
      XCTAssertNil(ultrafineDusts)
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_requestIntakesInWeek_error_noHealthKitPermission() {
    mockDustInfoService.fineDustHourlyValuePerDate = DummyDustInfoService.fineDustHourlyValuePerDate
    mockDustInfoService.ultrafineDustHourlyValuePerDate = DummyDustInfoService.ultrafineDustHourlyValuePerDate
    mockDustInfoService.error = nil
    mockHealthKitService.hourlyDistancePerDate = DummyHealthKitService.hourlyDistancePerDate
    mockHealthKitService.isAuthorized = false
    mockHealthKitService.error = nil
    mockCoreDataService.coreDataIntakePerDate = DummyCoreDataService.intakePerDateHalf
    mockCoreDataService.error = nil
    let expect = expectation(description: "test")
    intakeService.requestIntakesInWeek { fineDusts, ultrafineDusts, error in
      XCTAssertNil(fineDusts)
      XCTAssertNil(ultrafineDusts)
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
}
