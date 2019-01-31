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

  var mockHealthKitManager = MockHealthKitManager()
  
  var expectedResult = 0.0
  
  override func setUp() {
    expectedResult = 0.0
  }
  
  override func tearDown() {
    
  }
  
  /// 걸음수 결과 반환을 테스트함.
  func testCheckStepCount() {
    mockHealthKitManager.findHealthKitValue(startDate: Date(),
                                            endDate: Date(),
                                            quantityFor: HKUnit.count(),
                                            quantityTypeIdentifier: HKQuantityTypeIdentifier.stepCount
    ) { (value) -> Void in
      self.expectedResult = value
    }
    XCTAssertEqual(2314.0, expectedResult, "stepCount should be 2314.0")
    // error 보내는 부분 추가 되면 주석 풀겠습니다.
//    XCTAssertTrue(error.localizedDescription == HKError(.noError).localizedDescription)
  }
  
  /// 걸은 거리 결과 반환을 테스트함.
  func testChecktDistance() {
    mockHealthKitManager.findHealthKitValue(startDate: Date(),
                                            endDate: Date(),
                                            quantityFor: HKUnit.meter(),
                                            quantityTypeIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning
    ) { (value) -> Void in
      self.expectedResult = value
    }
    XCTAssertEqual(1409.53, expectedResult, "distance should be 1409.53")
    // error 보내는 부분 추가 되면 주석 풀겠습니다.
    //    XCTAssertTrue(error.localizedDescription == HKError(.noError).localizedDescription)
  }
  
  /// 나머지 identifier를 테스트함.
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
  
  /// HealthKit 데이터를 찾는 함수에 유효하지 않은 인자가 들어갔을 때 오류를 테스트함. 3
  func testfindHealthKitValueInvalidArgument() {
    mockHealthKitManager.findHealthKitValue(startDate: Date(),
                                            endDate: Date(),
                                            quantityFor: HKUnit.hour(),
                                            quantityTypeIdentifier: .stepCount) {
                                              (value) -> Void in
                                              self.expectedResult = value
    }
    // error 보내는 부분 추가 되면 주석 풀겠습니다.
//    XCTAssertTrue(error.localizedDescription == HKError(.errorInvalidArgument).localizedDescription)
  }
  
  /// HealthKit 권한 여부를 테스트함. 4 / 5 / 6
  func testHealthKitAuthrization() {
    
  }
  
  /// startDate 보다 endDate가 이전 날짜.
  func testFindHealthKitValueInWrongDate() {
    
  }
  
}
