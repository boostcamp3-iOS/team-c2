//
//  IntakeGeneratorTest.swift
//  FineDustTests
//
//  Created by Presto on 28/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import XCTest

class IntakeGeneratorTest: XCTestCase {
  
  var intakeGenerator = IntakeManager()
  
  var mockHealthKitManager = MockHealthKitManager()
  
  var mockAPI = MockAPI()
  
  override func setUp() {
    intakeGenerator.api = mockAPI
    intakeGenerator.healthKitManager = mockHealthKitManager
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
    var results: [Double] = []
    intakeGenerator.calculateIntakesInWeek(since: Date()) { values in
      results = values
      self.expectation(description: "calculate").fulfill()
    }
    waitForExpectations(timeout: 2, handler: nil)
    XCTAssertTrue(results.count == 7, "계산 결과 배열의 개수는 항상 7이어야 합니다")
  }
}
