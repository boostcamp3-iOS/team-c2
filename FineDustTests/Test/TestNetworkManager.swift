//
//  TestNetworkManager.swift
//  FineDustTests
//
//  Created by Presto on 19/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import Foundation
import XCTest

class TestNetworkManager: XCTestCase {
  
  let manager = NetworkManager.shared
  
  func test_request() {
    let expect = expectation(description: "test")
    let url = URL(string: "http://")!
    manager.request(url, method: .get, parameters: [:], headers: [:]) { data, statusCode, error in
      XCTAssertNil(data)
      XCTAssertEqual(statusCode, StatusCode.default)
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
}
