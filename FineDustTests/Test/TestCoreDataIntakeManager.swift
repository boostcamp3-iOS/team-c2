//
//  TestCoreDataIntakeManager.swift
//  FineDustTests
//
//  Created by Presto on 19/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import Foundation
import XCTest

class TestCoreDataIntakeManager: XCTestCase {
  
  let mockCoreDataManager = MockCoreDataManager()
  
  var intakeManager: CoreDataIntakeManager!
  
  override func setUp() {
    intakeManager = CoreDataIntakeManager(coreDataManager: mockCoreDataManager)
  }
  
  func test_request() {
    let expect = expectation(description: "test")
    intakeManager.request { intakes, error in
      XCTAssertNil(intakes)
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_save() {
    let expect = expectation(description: "test")
    intakeManager.save([Intake.ultrafineDust: 1]) { error in
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_request_error() {
    let expect = expectation(description: "test")
    mockCoreDataManager.error = NSError(domain: "", code: 0, userInfo: nil)
    intakeManager.request { intakes, error in
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_save_error() {
    let expect = expectation(description: "test")
    mockCoreDataManager.error = NSError(domain: "", code: 9, userInfo: nil)
    intakeManager.save([Intake.ultrafineDust: 1]) { error in
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
}
