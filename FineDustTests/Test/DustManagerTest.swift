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
  
  var dustManager: DustManager!
  
  let mockNetworkManager = MockNetworkManager()
  
  let url = URL(string: "http://www.asdf.com/")
  
  override func setUp() {
    dustManager = DustManager(networkManager: mockNetworkManager)
  }
  
  override func tearDown() {
    
  }
  
  /// 관측소 데이터를 가져온 것을 테스트
  func test_fetchObservatory() {
    let json = """
    { "key": "keykey", "value": "valuevalue" }
    """
    mockNetworkManager.data = json.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = nil
    let expect = expectation(description: "test")
    dustManager.fetchObservatory { response, error in
      XCTAssertNil(response)
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  /// 미세먼지 데이터를 가져온 것을 테스트
  func test_fetchDustInfo() {
    let json = """
    { "key": "keykey", "value": "valuevalue" }
    """
    mockNetworkManager.data = json.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = nil
    let expect = expectation(description: "test")
    dustManager.fetchDustInfo(term: .daily, numberOfRows: 1) { response, error in
      XCTAssertNil(response)
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  /// 관측소 데이터가 없는 것을 테스트
  func test_fetchObservatory_noData() {
    mockNetworkManager.data = nil
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = nil
    let expect = expectation(description: "test")
    dustManager.fetchObservatory { response, error in
      XCTAssertNil(response)
      XCTAssertNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  /// 미세먼지 데이터가 없는 것을 테스트
  func test_fetchDustInfo_noData() {
    mockNetworkManager.data = nil
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = nil
    let expect = expectation(description: "test")
    dustManager.fetchDustInfo(term: .daily, numberOfRows: 1) { response, error in
      XCTAssertNil(response)
      XCTAssertNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  /// 관측소 호출 중 네트워킹 에러 발생을 테스트
  func test_fetchObservatory_httpError() {
    mockNetworkManager.data = nil
    mockNetworkManager.httpStatusCode = HTTPStatusCode.default
    mockNetworkManager.error = HTTPError.default
    let expect = expectation(description: "test")
    dustManager.fetchObservatory { response, error in
      XCTAssertNil(response)
      if let err = error as? HTTPError {
        XCTAssertEqual(err, HTTPError.default)
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  /// 미세먼지 호출 중 네트워킹 에러 발생을 테스트
  func test_fetchDustInfo_httpError() {
    mockNetworkManager.data = nil
    mockNetworkManager.httpStatusCode = HTTPStatusCode.default
    mockNetworkManager.error = HTTPError.default
    let expect = expectation(description: "test")
    dustManager.fetchDustInfo(term: .daily, numberOfRows: 1) { response, error in
      XCTAssertNil(response)
      if let err = error as? HTTPError {
        XCTAssertEqual(err, HTTPError.default)
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  /// 관측소 호출 중 응답 관련 에러 발생을 테스트
  func test_fetchObservatory_dustError() {
    let json = """
    { "key": "keykey", "value": "valuevalue" }
    """
    mockNetworkManager.data = json.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = DustError.accessDenied
    let expect = expectation(description: "test")
    dustManager.fetchObservatory { response, error in
      XCTAssertNil(response)
      if let err = error as? DustError {
        XCTAssertEqual(err, DustError.accessDenied)
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  /// 미세먼지 호출 중 응답 관련 에러 발생을 테스트
  func test_fetchDustInfo_dustError() {
    let json = """
    { "key": "keykey", "value": "valuevalue" }
    """
    mockNetworkManager.data = json.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = DustError.accessDenied
    let expect = expectation(description: "test")
    dustManager.fetchDustInfo(term: .daily, numberOfRows: 1) { response, error in
      XCTAssertNil(response)
      if let err = error as? DustError {
        XCTAssertEqual(err, DustError.accessDenied)
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
}
