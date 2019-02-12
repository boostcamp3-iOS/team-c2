//
//  DustObservatoryManagerTest.swift
//  FineDustTests
//
//  Created by Presto on 12/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import Foundation
import XCTest

class TestDustObservatoryManager: XCTestCase {
  
  let mockNetworkManager = MockNetworkManager()
  
  var dustObservatoryManager: DustObservatoryManager!
  
  override func setUp() {
    dustObservatoryManager = DustObservatoryManager(networkManager: mockNetworkManager)
  }
  
  func test_requestObservatory() {
    let json = """
    { "key": "keykey", "value": "valuevalue" }
    """
    mockNetworkManager.data = json.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = nil
    let expect = expectation(description: "test")
    dustObservatoryManager.requestObservatory(numberOfRows: 1, pageNumber: 1) { response, error in
      XCTAssertNil(response)
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_requestObservatory_error() {
    mockNetworkManager.data = nil
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = nil
    let expect = expectation(description: "test")
    dustObservatoryManager.requestObservatory(numberOfRows: 1, pageNumber: 1) { response, error in
      XCTAssertNil(response)
      XCTAssertNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_requestObservatory_httpError() {
    mockNetworkManager.data = nil
    mockNetworkManager.httpStatusCode = HTTPStatusCode.default
    mockNetworkManager.error = HTTPError.default
    let expect = expectation(description: "test")
    dustObservatoryManager.requestObservatory(numberOfRows: 1, pageNumber: 1) { response, error in
      XCTAssertNil(response)
      if let error = error as? HTTPError {
        XCTAssertEqual(error, HTTPError.default)
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_requestObservatory_dustError() {
    let json = """
    { "key": "keykey", "value": "valuevalue" }
    """
    mockNetworkManager.data = json.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = DustError.accessDenied
    let expect = expectation(description: "test")
    dustObservatoryManager.requestObservatory(numberOfRows: 1, pageNumber: 1) { response, error in
      XCTAssertNil(response)
      if let error = error as? DustError {
        XCTAssertEqual(error, DustError.accessDenied)
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_requestObservatory_xmlError1() {
    let json = """
    { "key": "keykey", "value": "valuevalue" }
    """
    mockNetworkManager.data = json.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = XMLError.implementationIsMissing("asdf")
    let expect = expectation(description: "test")
    dustObservatoryManager.requestObservatory(numberOfRows: 1, pageNumber: 1) { response, error in
      XCTAssertNil(response)
      if let error = error as? XMLError {
        XCTAssertEqual(error, XMLError.implementationIsMissing("asdf"))
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_requesetObservatory_xmlError2() {
    let json = """
    { "key": "keykey", "value": "valuevalue" }
    """
    mockNetworkManager.data = json.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = XMLError.nodeHasNoValue
    let expect = expectation(description: "test")
    dustObservatoryManager.requestObservatory(numberOfRows: 1, pageNumber: 1) { response, error in
      XCTAssertNil(response)
      if let error = error as? XMLError {
        XCTAssertEqual(error, XMLError.nodeHasNoValue)
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
}
