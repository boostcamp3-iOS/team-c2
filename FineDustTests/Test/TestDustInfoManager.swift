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
    mockNetworkManager.data = DummyNetworkManager.dustInfoResponse.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = nil
    let expect = expectation(description: "test")
    dustInfoManager.request(dataTerm: .daily, numberOfRows: 1, pageNumber: 1) { response, error in
      XCTAssertNotNil(response)
      XCTAssertNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }

  func test_request_noDataError() {
    mockNetworkManager.data = nil
    mockNetworkManager.httpStatusCode = HTTPStatusCode.default
    mockNetworkManager.error = NSError(domain: "", code: 0, userInfo: nil)
    let expect = expectation(description: "test")
    dustInfoManager.request(dataTerm: .daily, numberOfRows: 1, pageNumber: 1) { response, error in
      XCTAssertNil(response)
      XCTAssertNotNil(error)
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
  
  /// 에러 대신 더미를 따로 다 정의해야함..
  
  func test_request_dustError1() {
    mockNetworkManager.data = DummyNetworkManager.dustInfoResponseApplicationError.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = nil
    let expect = expectation(description: "test")
    dustInfoManager.request(dataTerm: .daily, numberOfRows: 1, pageNumber: 1) { response, error in
      XCTAssertNil(response)
      if let error = error as? DustError {
        XCTAssertEqual(error, DustError.applicationError)
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_request_dustError2() {
    mockNetworkManager.data = DummyNetworkManager.dustInfoResponseDBError.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = nil
    let expect = expectation(description: "test")
    dustInfoManager.request(dataTerm: .daily, numberOfRows: 1, pageNumber: 1) { response, error in
      XCTAssertNil(response)
      if let error = error as? DustError {
        XCTAssertEqual(error, DustError.dbError)
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_request_dustError3() {
    mockNetworkManager.data = DummyNetworkManager.dustInfoResponseNoData.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = nil
    let expect = expectation(description: "test")
    dustInfoManager.request(dataTerm: .daily, numberOfRows: 1, pageNumber: 1) { response, error in
      XCTAssertNil(response)
      if let error = error as? DustError {
        XCTAssertEqual(error, DustError.noData)
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_request_dustError4() {
    mockNetworkManager.data = DummyNetworkManager.dustInfoResponseHTTPError.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = nil
    let expect = expectation(description: "test")
    dustInfoManager.request(dataTerm: .daily, numberOfRows: 1, pageNumber: 1) { response, error in
      XCTAssertNil(response)
      if let error = error as? DustError {
        XCTAssertEqual(error, DustError.httpError)
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_request_dustError5() {
    mockNetworkManager.data = DummyNetworkManager.dustInfoResponseServiceTimeOut.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = nil
    let expect = expectation(description: "test")
    dustInfoManager.request(dataTerm: .daily, numberOfRows: 1, pageNumber: 1) { response, error in
      XCTAssertNil(response)
      if let error = error as? DustError {
        XCTAssertEqual(error, DustError.serviceTimeOut)
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_request_dustError6() {
    mockNetworkManager.data = DummyNetworkManager.dustInfoResponseInvalidRequestParameter.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = nil
    let expect = expectation(description: "test")
    dustInfoManager.request(dataTerm: .daily, numberOfRows: 1, pageNumber: 1) { response, error in
      XCTAssertNil(response)
      if let error = error as? DustError {
        XCTAssertEqual(error, DustError.invalidRequestParameter)
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_request_dustError7() {
    mockNetworkManager.data = DummyNetworkManager.dustInfoResponseNoRequiredRequestParameter.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = nil
    let expect = expectation(description: "test")
    dustInfoManager.request(dataTerm: .daily, numberOfRows: 1, pageNumber: 1) { response, error in
      XCTAssertNil(response)
      if let error = error as? DustError {
        XCTAssertEqual(error, DustError.noRequiredRequestParameter)
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_request_dustError8() {
    mockNetworkManager.data = DummyNetworkManager.dustInfoResponseNoServiceOrDeprecated.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = nil
    let expect = expectation(description: "test")
    dustInfoManager.request(dataTerm: .daily, numberOfRows: 1, pageNumber: 1) { response, error in
      XCTAssertNil(response)
      if let error = error as? DustError {
        XCTAssertEqual(error, DustError.noServiceOrDeprecated)
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_request_dustError9() {
    mockNetworkManager.data = DummyNetworkManager.dustInfoResponseAccessDenied.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = nil
    let expect = expectation(description: "test")
    dustInfoManager.request(dataTerm: .daily, numberOfRows: 1, pageNumber: 1) { response, error in
      XCTAssertNil(response)
      if let error = error as? DustError {
        XCTAssertEqual(error, DustError.accessDenied)
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_request_dustError10() {
    mockNetworkManager.data = DummyNetworkManager.dustInfoResponseExceededRequestLimit.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = nil
    let expect = expectation(description: "test")
    dustInfoManager.request(dataTerm: .daily, numberOfRows: 1, pageNumber: 1) { response, error in
      XCTAssertNil(response)
      if let error = error as? DustError {
        XCTAssertEqual(error, DustError.exceededRequestLimit)
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_request_dustError11() {
    mockNetworkManager.data = DummyNetworkManager.dustInfoResponseUnregisteredServiceKey.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = nil
    let expect = expectation(description: "test")
    dustInfoManager.request(dataTerm: .daily, numberOfRows: 1, pageNumber: 1) { response, error in
      XCTAssertNil(response)
      if let error = error as? DustError {
        XCTAssertEqual(error, DustError.unregisteredServiceKey)
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_request_dustError12() {
    mockNetworkManager.data = DummyNetworkManager.dustInfoResponseExpiredServiceKey.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = nil
    let expect = expectation(description: "test")
    dustInfoManager.request(dataTerm: .daily, numberOfRows: 1, pageNumber: 1) { response, error in
      XCTAssertNil(response)
      if let error = error as? DustError {
        XCTAssertEqual(error, DustError.expiredServiceKey)
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_request_dustError13() {
    mockNetworkManager.data = DummyNetworkManager.dustInfoResponseUnregisteredDomainOfIPAddress.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = nil
    let expect = expectation(description: "test")
    dustInfoManager.request(dataTerm: .daily, numberOfRows: 1, pageNumber: 1) { response, error in
      XCTAssertNil(response)
      if let error = error as? DustError {
        XCTAssertEqual(error, DustError.unregisteredDomainOfIPAddress)
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_request_dustError14() {
    mockNetworkManager.data = DummyNetworkManager.dustInfoResponseDefault.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = nil
    let expect = expectation(description: "test")
    dustInfoManager.request(dataTerm: .daily, numberOfRows: 1, pageNumber: 1) { response, error in
      XCTAssertNil(response)
      if let error = error as? DustError {
        XCTAssertEqual(error, DustError.default)
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
}
