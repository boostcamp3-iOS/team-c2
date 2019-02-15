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
    mockNetworkManager.data = DummyNetworkManager.observatoryResponse.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = nil
    let expect = expectation(description: "test")
    dustObservatoryManager.requestObservatory(numberOfRows: 1, pageNumber: 1) { response, error in
      XCTAssertNotNil(response)
      XCTAssertNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_requestObservatory_noData() {
    mockNetworkManager.data = nil
    mockNetworkManager.httpStatusCode = .success
    mockNetworkManager.error = NSError(domain: "nodata", code: 0, userInfo: nil)
    let expect = expectation(description: "test")
    dustObservatoryManager.requestObservatory(numberOfRows: 1, pageNumber: 1) { response, error in
      XCTAssertNil(response)
      XCTAssertNotNil(error)
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
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_requestObservatory_dustError1() {
    mockNetworkManager.data = DummyNetworkManager.dustInfoResponseApplicationError.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = nil
    let expect = expectation(description: "test")
    dustObservatoryManager.requestObservatory(numberOfRows: 1, pageNumber: 1) { response, error in
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
  
  func test_requestObservatory_dustError2() {
    mockNetworkManager.data = DummyNetworkManager.dustInfoResponseDBError.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = nil
    let expect = expectation(description: "test")
    dustObservatoryManager.requestObservatory(numberOfRows: 1, pageNumber: 1) { response, error in
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
  
  func test_requestObservatory_dustError3() {
    mockNetworkManager.data = DummyNetworkManager.dustInfoResponseNoData.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = nil
    let expect = expectation(description: "test")
    dustObservatoryManager.requestObservatory(numberOfRows: 1, pageNumber: 1) { response, error in
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
  
  func test_requestObservatory_dustError4() {
    mockNetworkManager.data = DummyNetworkManager.dustInfoResponseHTTPError.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = nil
    let expect = expectation(description: "test")
    dustObservatoryManager.requestObservatory(numberOfRows: 1, pageNumber: 1) { response, error in
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
  
  func test_requestObservatory_dustError5() {
    mockNetworkManager.data = DummyNetworkManager.dustInfoResponseServiceTimeOut.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = nil
    let expect = expectation(description: "test")
    dustObservatoryManager.requestObservatory(numberOfRows: 1, pageNumber: 1) { response, error in
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
  
  func test_requestObservatory_dustError6() {
    mockNetworkManager.data = DummyNetworkManager.dustInfoResponseInvalidRequestParameter.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = nil
    let expect = expectation(description: "test")
    dustObservatoryManager.requestObservatory(numberOfRows: 1, pageNumber: 1) { response, error in
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
  
  func test_requestObservatory_dustError7() {
    mockNetworkManager.data = DummyNetworkManager.dustInfoResponseNoRequiredRequestParameter.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = nil
    let expect = expectation(description: "test")
    dustObservatoryManager.requestObservatory(numberOfRows: 1, pageNumber: 1) { response, error in
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
  
  func test_requestObservatory_dustError8() {
    mockNetworkManager.data = DummyNetworkManager.dustInfoResponseNoServiceOrDeprecated.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = nil
    let expect = expectation(description: "test")
    dustObservatoryManager.requestObservatory(numberOfRows: 1, pageNumber: 1) { response, error in
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
  
  func test_requestObservatory_dustError9() {
    mockNetworkManager.data = DummyNetworkManager.dustInfoResponseAccessDenied.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = nil
    let expect = expectation(description: "test")
    dustObservatoryManager.requestObservatory(numberOfRows: 1, pageNumber: 1) { response, error in
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
  
  func test_requestObservatory_dustError10() {
    mockNetworkManager.data = DummyNetworkManager.dustInfoResponseExceededRequestLimit.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = nil
    let expect = expectation(description: "test")
    dustObservatoryManager.requestObservatory(numberOfRows: 1, pageNumber: 1) { response, error in
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
  
  func test_requestObservatory_dustError11() {
    mockNetworkManager.data = DummyNetworkManager.dustInfoResponseUnregisteredServiceKey.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = nil
    let expect = expectation(description: "test")
    dustObservatoryManager.requestObservatory(numberOfRows: 1, pageNumber: 1) { response, error in
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
  
  func test_requestObservatory_dustError12() {
    mockNetworkManager.data = DummyNetworkManager.dustInfoResponseExpiredServiceKey.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = nil
    let expect = expectation(description: "test")
    dustObservatoryManager.requestObservatory(numberOfRows: 1, pageNumber: 1) { response, error in
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
  
  func test_requestObservatory_dustError13() {
    mockNetworkManager.data = DummyNetworkManager.dustInfoResponseUnregisteredDomainOfIPAddress.data(using: .utf8)
    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
    mockNetworkManager.error = nil
    let expect = expectation(description: "test")
    dustObservatoryManager.requestObservatory(numberOfRows: 1, pageNumber: 1) { response, error in
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

  
//  func test_requestObservatory_xmlError1() {
//    mockNetworkManager.data = DummyNetworkManager.observatoryResponse.data(using: .utf8)
//    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
//    mockNetworkManager.error = XMLError.attributeDeserializationFailed("", .init(name: "", text: ""))
//    let expect = expectation(description: "test")
//    dustObservatoryManager.requestObservatory(numberOfRows: 1, pageNumber: 1) { response, error in
//      XCTAssertNotNil(response)
//      if let error = error as? XMLError {
//        XCTAssertEqual(error, XMLError.attributeDeserializationFailed("", .init(name: "", text: "")))
//      }
//      expect.fulfill()
//    }
//    waitForExpectations(timeout: 5, handler: nil)
//  }
//
//  func test_requesetObservatory_xmlError2() {
//    mockNetworkManager.data = DummyNetworkManager.observatoryResponse.data(using: .utf8)
//    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
//    mockNetworkManager.error = XMLError.attributeDoesNotExist(.init(name: "", options: .init()), "")
//    let expect = expectation(description: "test")
//    dustObservatoryManager.requestObservatory(numberOfRows: 1, pageNumber: 1) { response, error in
//      XCTAssertNotNil(response)
//      if let error = error as? XMLError {
//        XCTAssertEqual(error, XMLError.attributeDoesNotExist(.init(name: "", options: .init()), ""))
//      }
//      expect.fulfill()
//    }
//    waitForExpectations(timeout: 5, handler: nil)
//  }
//
//  func test_requestObservatory_xmlError3() {
//    mockNetworkManager.data = DummyNetworkManager.observatoryResponse.data(using: .utf8)
//    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
//    mockNetworkManager.error = XMLError.default
//    let expect = expectation(description: "test")
//    dustObservatoryManager.requestObservatory(numberOfRows: 1, pageNumber: 1) { response, error in
//      XCTAssertNotNil(response)
//      if let error = error as? XMLError {
//        XCTAssertEqual(error, XMLError.default)
//      }
//      expect.fulfill()
//    }
//    waitForExpectations(timeout: 5, handler: nil)
//  }
//
//  func test_requestObservatory_xmlError4() {
//    mockNetworkManager.data = DummyNetworkManager.observatoryResponse.data(using: .utf8)
//    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
//    mockNetworkManager.error = XMLError.implementationIsMissing("")
//    let expect = expectation(description: "test")
//    dustObservatoryManager.requestObservatory(numberOfRows: 1, pageNumber: 1) { response, error in
//      XCTAssertNotNil(response)
//      if let error = error as? XMLError {
//        XCTAssertEqual(error, XMLError.implementationIsMissing(""))
//      }
//      expect.fulfill()
//    }
//    waitForExpectations(timeout: 5, handler: nil)
//  }
//
//  func test_requestObservatory_xmlError5() {
//    mockNetworkManager.data = DummyNetworkManager.observatoryResponse.data(using: .utf8)
//    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
//    mockNetworkManager.error = XMLError.nodeHasNoValue
//    let expect = expectation(description: "test")
//    dustObservatoryManager.requestObservatory(numberOfRows: 1, pageNumber: 1) { response, error in
//      XCTAssertNotNil(response)
//      if let error = error as? XMLError {
//        XCTAssertEqual(error, XMLError.nodeHasNoValue)
//      }
//      expect.fulfill()
//    }
//    waitForExpectations(timeout: 5, handler: nil)
//  }
//
//  func test_requestObservatory_xmlError6() {
//    mockNetworkManager.data = DummyNetworkManager.observatoryResponse.data(using: .utf8)
//    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
//    mockNetworkManager.error = XMLError.nodeIsInvalid(.element(.init(name: "", options: .init())))
//    let expect = expectation(description: "test")
//    dustObservatoryManager.requestObservatory(numberOfRows: 1, pageNumber: 1) { response, error in
//      XCTAssertNotNil(response)
//      if let error = error as? XMLError {
//        XCTAssertEqual(error, XMLError.nodeIsInvalid(.element(.init(name: "", options: .init()))))
//      }
//      expect.fulfill()
//    }
//    waitForExpectations(timeout: 5, handler: nil)
//  }
//
//  func test_requestObservatory_xmlError7() {
//    mockNetworkManager.data = DummyNetworkManager.observatoryResponse.data(using: .utf8)
//    mockNetworkManager.httpStatusCode = HTTPStatusCode.success
//    mockNetworkManager.error = XMLError.typeConversionFailed("", .init(name: "", options: .init()))
//    let expect = expectation(description: "test")
//    dustObservatoryManager.requestObservatory(numberOfRows: 1, pageNumber: 1) { response, error in
//      XCTAssertNotNil(response)
//      if let error = error as? XMLError {
//        XCTAssertEqual(error, XMLError.typeConversionFailed("", .init(name: "", options: .init())))
//      }
//      expect.fulfill()
//    }
//    waitForExpectations(timeout: 5, handler: nil)
//  }
}
