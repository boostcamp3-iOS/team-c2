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
  
  /// 오늘 걸음 수 데이터 받아오는 함수 테스트
  func testFetchTodayStepCount() {
    let expect = expectation(description: "fetch today step count")
    healthKitService?.fetchTodayStepCount { result, error in
      XCTAssertEqual(result, self.mockHealthKitManager.stepCount)
      XCTAssertNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  /// 오늘 걸은 거리 데이터 받아오는 함수 테스트
  func testFetchTodayDistance() {
    let expect = expectation(description: "fetch today distance")
    healthKitService?.fetchTodayDistance { result, error in
      XCTAssertEqual(result, self.mockHealthKitManager.distance)
      XCTAssertNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  /// 오늘 걸음 수 데이터 받아오는 함수 에러 테스트
  func testFetchTodayStepCountError() {
    let expect = expectation(description: "fetch error")
    mockHealthKitManager.error = NSError(domain: "domain", code: 0, userInfo: nil)
    healthKitService?.fetchTodayStepCount { result, error in
      XCTAssertEqual(result, 0.0)
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  /// 오늘 걸은 거리 데이터 받아오는 함수 에러 테스트
  func testFetchTodayDistanceError() {
    let expect = expectation(description: "fetch error")
    mockHealthKitManager.error = NSError(domain: "domain", code: 0, userInfo: nil)
    healthKitService?.fetchTodayDistance { result, error in
      XCTAssertEqual(result, 0.0)
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
}
