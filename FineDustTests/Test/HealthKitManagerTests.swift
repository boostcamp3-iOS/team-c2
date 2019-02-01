//
//  HealthKitManagerTests.swift
//  FineDustTests
//
//  Created by zun on 01/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//
@testable import FineDust
import XCTest

class HealthKitManagerTests: XCTestCase {
  
  let mockHealthKitManager = MockHealthKitManager()
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testFetchStepCount() {
    var value: Double?
    let expt = expectation(description: "Waiting...")
    mockHealthKitManager.input = 1
    mockHealthKitManager.fetchStepCount(startDate: Date.start(), endDate: Date()) {
      value = $0
      XCTAssertEqual(self.mockHealthKitManager.input, value)
      expt.fulfill()
    }
    
    waitForExpectations(timeout: 5.0, handler: nil)
    
  }
  
  func testFetchStepCountDate() {
    var value: Double?
    let expt = expectation(description: "Waiting...")
    mockHealthKitManager.input = 1
    mockHealthKitManager.fetchStepCount(startDate: Date(), endDate: Date.start()) {
      value = $0
      XCTAssertEqual(value, nil)
      expt.fulfill()
    }
    
    waitForExpectations(timeout: 5.0, handler: nil)
  }
  
  func testExample() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
  }
  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}
