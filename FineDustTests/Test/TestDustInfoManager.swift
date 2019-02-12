//
//  DustInfoManagerTest.swift
//  FineDustTests
//
//  Created by Presto on 12/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import Foundation
import XCTest

class TestDustInfoManager: XCTestCase {
  
  let mockNetworkManager = MockNetworkManager()
  
  var dustInfoManager: DustInfoManager!
  
  override func setUp() {
    dustInfoManager = DustInfoManager(networkManager: mockNetworkManager)
  }
  
  func test_request() {
    let json = """
    { "key": "keykey", "value": "valuevalue" }
    """
    mockNetworkManager.data = json.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = nil
    let expect = expectation(description: "test")
    dustInfoManager.request(dataTerm: .daily, numberOfRows: 1, pageNumber: 1) { response, error in
      XCTAssertNil(response)
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }

  func test_request_noDataError() {
    mockNetworkManager.data = nil
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = nil
    let expect = expectation(description: "test")
    dustInfoManager.request(dataTerm: .daily, numberOfRows: 1, pageNumber: 1) { response, error in
      XCTAssertNil(response)
      XCTAssertNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_request_httpError() {
    mockNetworkManager.data = nil
    mockNetworkManager.httpStatusCode = HTTPStatusCode.default
    mockNetworkManager.error = HTTPError.default
    let expect = expectation(description: "test")
    dustInfoManager.request(dataTerm: .daily, numberOfRows: 1, pageNumber: 1) { response, error in
      XCTAssertNil(response)
      if let error = error as? HTTPError {
        XCTAssertEqual(error, HTTPError.default)
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_request_dustError() {
    let json = """
    { "key": "keykey", "value": "valuevalue" }
    """
    mockNetworkManager.data = json.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = DustError.accessDenied
    let expect = expectation(description: "test")
    dustInfoManager.request(dataTerm: .daily, numberOfRows: 1, pageNumber: 1) { response, error in
      XCTAssertNil(response)
      if let error = error as? DustError {
        XCTAssertEqual(error, DustError.accessDenied)
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
}
