//
//  IntakeGeneratorTest.swift
//  FineDustTests
//
//  Created by Presto on 28/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import XCTest

class IntakeManagerTest: XCTestCase {
  
  var intakeManager = IntakeManager()
  
  var mockHealthKitManager = MockHealthKitManager()
  
  var mockAPI = MockAPI()
  
  override func setUp() {
    intakeManager.api = mockAPI
    intakeManager.healthKitManager = mockHealthKitManager
  }
  
  override func tearDown() {
    
  }
  
  // 3. 2에서 정의한 함수를 테스트하는 테스트 함수를 만듦
  func testIntakeGeneratorAlgorithm() {
    mockAPI.observatoryResponse = ObservatoryResponse(
      list: [ObservatoryResponse.List(address: "address",
                                      observatory: "observatory",
                                      distance: 888)],
      totalCount: 3
    )
    mockAPI.fineDustResponse = FineDustResponse(
      list: [FineDustResponse.List(dataTime: "20182938",
                                   fineDustValue: 1,
                                   fineDustValue24: 2,
                                   fineDustGrade: 3,
                                   fineDustGrade1h: 4,
                                   ultraFineDustValue: 5,
                                   ultraFineDustValue24: 6,
                                   ultraFineDustGrade: 7,
                                   ultraFineDustGrade1h: 8)], totalCount: 23)
    mockHealthKitManager.distance = 1623
    mockHealthKitManager.steps = 4726
    var result: Double = 0.0
    intakeManager.calculateIntakesInWeek(since: Date()) { value in
      result = value
      self.expectation(description: "calculate").fulfill()
    }
    waitForExpectations(timeout: 2, handler: nil)
    XCTAssertFalse(result == 0, "result는 0이 되어서는 안됩니다")
  }
}
