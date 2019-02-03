//
//  DustManagerTest.swift
//  FineDustTests
//
//  Created by Presto on 01/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust

import Foundation
import XCTest

class DustManagerTest: XCTestCase {
  
  // 올바른 XML 데이터(Data)에 대한 Status Code를 받아 success(00)이 아닐 때의 경우를 테스트해야 함
  
  let mockNetworkManager = MockNetworkManager()
  
  let url = URL(string: "http://www.asdf.com/")
  
  /// 관측소 데이터를 가져온 것을 테스트
  func testFetchObservatory() {
    let dustManager = DustObservatoryManager(networkManager: mockNetworkManager)
    let json = """
    { "key": "keykey", "value": "valuevalue" }
    """
    mockNetworkManager.data = json.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = nil
    let expect = expectation(description: "test")
    dustManager.fetchObservatory(numberOfRows: 1, pageNumber: 1) { response, error in
      XCTAssertNil(response)
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  /// 미세먼지 데이터를 가져온 것을 테스트
  func testFetchDustInfo() {
    let dustManager = DustInfoManager(networkManager: mockNetworkManager)
    let json = """
    { "key": "keykey", "value": "valuevalue" }
    """
    mockNetworkManager.data = json.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = nil
    let expect = expectation(description: "test")
    dustManager.fetchDustInfo(term: .daily, numberOfRows: 1, pageNumber: 1) { response, error in
      XCTAssertNil(response)
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  /// 관측소 데이터가 없는 것을 테스트
  func testFetchObservatoryNoData() {
    let dustManager = DustObservatoryManager(networkManager: mockNetworkManager)
    mockNetworkManager.data = nil
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = nil
    let expect = expectation(description: "test")
    dustManager.fetchObservatory(numberOfRows: 1, pageNumber: 1) { response, error in
      XCTAssertNil(response)
      XCTAssertNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  /// 미세먼지 데이터가 없는 것을 테스트
  func testFetchDustInfoNoData() {
    let dustManager = DustInfoManager(networkManager: mockNetworkManager)
    mockNetworkManager.data = nil
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = nil
    let expect = expectation(description: "test")
    dustManager.fetchDustInfo(term: .daily, numberOfRows: 1, pageNumber: 1) { response, error in
      XCTAssertNil(response)
      XCTAssertNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  /// 관측소 호출 중 네트워킹 에러 발생을 테스트
  func testFetchObservatoryHTTPError() {
    let dustManager = DustObservatoryManager(networkManager: mockNetworkManager)
    mockNetworkManager.data = nil
    mockNetworkManager.httpStatusCode = HTTPStatusCode.default
    mockNetworkManager.error = HTTPError.default
    let expect = expectation(description: "test")
    dustManager.fetchObservatory(numberOfRows: 1, pageNumber: 1) { response, error in
      XCTAssertNil(response)
      if let error = error as? HTTPError {
        XCTAssertEqual(error, HTTPError.default)
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  /// 미세먼지 호출 중 네트워킹 에러 발생을 테스트
  func testFetchDustInfoHTTPError() {
    let dustManager = DustInfoManager(networkManager: mockNetworkManager)
    mockNetworkManager.data = nil
    mockNetworkManager.httpStatusCode = HTTPStatusCode.default
    mockNetworkManager.error = HTTPError.default
    let expect = expectation(description: "test")
    dustManager.fetchDustInfo(term: .daily, numberOfRows: 1, pageNumber: 1) { response, error in
      XCTAssertNil(response)
      if let error = error as? HTTPError {
        XCTAssertEqual(error, HTTPError.default)
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  /// 관측소 호출 중 응답 관련 에러 발생을 테스트
  func testFetchObservatoryDustError() {
    let dustManager = DustObservatoryManager(networkManager: mockNetworkManager)
    let json = """
    { "key": "keykey", "value": "valuevalue" }
    """
    mockNetworkManager.data = json.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = DustError.accessDenied
    let expect = expectation(description: "test")
    dustManager.fetchObservatory(numberOfRows: 1, pageNumber: 1) { response, error in
      XCTAssertNil(response)
      if let error = error as? DustError {
        XCTAssertEqual(error, DustError.accessDenied)
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  /// 미세먼지 호출 중 응답 관련 에러 발생을 테스트
  func testFetchDustInfoDustError() {
    let dustManager = DustInfoManager(networkManager: mockNetworkManager)
    let json = """
    { "key": "keykey", "value": "valuevalue" }
    """
    mockNetworkManager.data = json.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = DustError.accessDenied
    let expect = expectation(description: "test")
    dustManager.fetchDustInfo(term: .daily, numberOfRows: 1, pageNumber: 1) { response, error in
      XCTAssertNil(response)
      if let error = error as? DustError {
        XCTAssertEqual(error, DustError.accessDenied)
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func testFetchObservatoryXMLError1() {
    let dustManager = DustObservatoryManager(networkManager: mockNetworkManager)
    let json = """
    { "key": "keykey", "value": "valuevalue" }
    """
    mockNetworkManager.data = json.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = XMLError.implementationIsMissing("asdf")
    let expect = expectation(description: "test")
    dustManager.fetchObservatory(numberOfRows: 1, pageNumber: 1) { response, error in
      XCTAssertNil(response)
      if let error = error as? XMLError {
        XCTAssertEqual(error, XMLError.implementationIsMissing("asdf"))
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func testFetchObservatoryXMLError2() {
    let dustManager = DustObservatoryManager(networkManager: mockNetworkManager)
    dustManager.networkManager = mockNetworkManager
    let json = """
    { "key": "keykey", "value": "valuevalue" }
    """
    mockNetworkManager.data = json.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = XMLError.nodeHasNoValue
    let expect = expectation(description: "test")
    dustManager.fetchObservatory(numberOfRows: 1, pageNumber: 1) { response, error in
      XCTAssertNil(response)
      if let error = error as? XMLError {
        XCTAssertEqual(error, XMLError.nodeHasNoValue)
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
}
