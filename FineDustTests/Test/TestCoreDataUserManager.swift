//
//  TestCoreDataUserManager.swift
//  FineDustTests
//
//  Created by Presto on 19/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import Foundation
import XCTest

class TestCoreDataUserManager: XCTestCase {
  
  let mockCoreDataManager = MockCoreDataManager()
  
  var userManager: CoreDataUserManager!
  
  override func setUp() {
    userManager = CoreDataUserManager(coreDataManager: mockCoreDataManager)
  }
  
  func test_request() {
    let expect = expectation(description: "test")
    userManager.request { user, error in
      XCTAssertNil(user)
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_save() {
    let expect = expectation(description: "test")
    userManager.save([User.address: ""]) { error in
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_request_error() {
    let expect = expectation(description: "test")
    mockCoreDataManager.error = NSError(domain: "", code: 0, userInfo: nil)
    userManager.request { user, error in
      XCTAssertNil(user)
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_save_error() {
    let expect = expectation(description: "test")
    mockCoreDataManager.error = NSError(domain: "", code: 0, userInfo: nil)
    userManager.save([User.address: ""]) { error in
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
}
