//
//  TestIntakeRequestable.swift
//  FineDustTests
//
//  Created by Presto on 22/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import Foundation
import XCTest

class TestStatisticsViewController: XCTestCase {
  
  let mockIntakeService = MockIntakeService()
  
  let mockCoreDataService = MockCoreDataService()
  
  var viewController: StatisticsViewController!
  
  override func setUp() {
    let storyboard = UIStoryboard(name: "Statistics", bundle: nil)
    viewController = storyboard.instantiateViewController(withIdentifier: StatisticsViewController.classNameToString) as? StatisticsViewController
    _ = viewController.view
    
  }
  
  func test_requestIntake() {
    mockIntakeService.todayFineDust = 1
    mockIntakeService.todayUltrafineDust = 1
    mockIntakeService.weekFineDust = [1]
    mockIntakeService.weekUltrafineDust = [1]
    mockIntakeService.todayIntakeError = nil
    mockIntakeService.weekIntakeError = nil
    mockCoreDataService.error = nil
    viewController.injectDependency(mockIntakeService, mockCoreDataService)
    let expect = expectation(description: "test")
    viewController.requestIntake { intakeData, error in
      XCTAssertNotNil(intakeData?.weekFineDust)
      XCTAssertNotNil(intakeData?.weekUltrafineDust)
      XCTAssertNotNil(intakeData?.todayFineDust)
      XCTAssertNotNil(intakeData?.todayUltrafineDust)
      XCTAssertNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_requestIntake_error_today() {
    mockIntakeService.todayFineDust = nil
    mockIntakeService.todayUltrafineDust = nil
    mockIntakeService.weekFineDust = nil
    mockIntakeService.weekUltrafineDust = nil
    mockIntakeService.todayIntakeError = NSError(domain: "", code: 0, userInfo: nil)
    mockIntakeService.weekIntakeError = nil
    mockCoreDataService.error = nil
    viewController.injectDependency(mockIntakeService, mockCoreDataService)
    let expect = expectation(description: "test")
    viewController.requestIntake { intakeData, error in
      XCTAssertNil(intakeData?.weekFineDust)
      XCTAssertNil(intakeData?.weekUltrafineDust)
      XCTAssertNil(intakeData?.todayFineDust)
      XCTAssertNil(intakeData?.todayUltrafineDust)
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_requestIntake_error_week() {
    mockIntakeService.todayFineDust = nil
    mockIntakeService.todayUltrafineDust = nil
    mockIntakeService.weekFineDust = nil
    mockIntakeService.weekUltrafineDust = nil
    mockIntakeService.todayIntakeError = nil
    mockIntakeService.weekIntakeError = NSError(domain: "", code: 0, userInfo: nil)
    mockCoreDataService.error = nil
    viewController.injectDependency(mockIntakeService, mockCoreDataService)
    let expect = expectation(description: "test")
    viewController.requestIntake { intakeData, error in
      XCTAssertNil(intakeData?.weekFineDust)
      XCTAssertNil(intakeData?.weekUltrafineDust)
      XCTAssertNil(intakeData?.todayFineDust)
      XCTAssertNil(intakeData?.todayUltrafineDust)
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_requestIntake_error_coreData() {
    mockIntakeService.todayFineDust = 1
    mockIntakeService.todayUltrafineDust = 1
    mockIntakeService.weekFineDust = [1]
    mockIntakeService.weekUltrafineDust = [1]
    mockIntakeService.todayIntakeError = nil
    mockIntakeService.weekIntakeError = nil
    mockCoreDataService.error = NSError(domain: "", code: 0, userInfo: nil)
    viewController.injectDependency(mockIntakeService, mockCoreDataService)
    let expect = expectation(description: "test")
    viewController.requestIntake { intakeData, error in
      XCTAssertNotNil(intakeData?.weekFineDust)
      XCTAssertNotNil(intakeData?.weekUltrafineDust)
      XCTAssertNotNil(intakeData?.todayFineDust)
      XCTAssertNotNil(intakeData?.todayUltrafineDust)
      XCTAssertNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
}
