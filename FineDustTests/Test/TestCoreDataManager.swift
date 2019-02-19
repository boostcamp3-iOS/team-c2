//
//  TestCoreDataManager.swift
//  FineDustTests
//
//  Created by Presto on 19/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import Foundation
import XCTest

class TestCoreDataManager: XCTestCase {
  
  let manager = CoreDataManager()
  
  func test_save() {
    let expect = expectation(description: "test")
    manager.save(["": 1]) { error in
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
}
