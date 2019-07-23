//
//  TestXMLManager.swift
//  FineDustTests
//
//  Created by Presto on 15/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import Foundation
import XCTest

class TestXMLManager: XCTestCase {
  
  var mockXMLDecoder = MockXMLDecoder()
  
  var xmlManager: XMLManager!
  
  override func setUp() {
    xmlManager = XMLManager(xmlDecoder: mockXMLDecoder)
  }
  
  func test_parse_headerResponse() {
    let expect = expectation(description: "test")
    mockXMLDecoder.error = nil
    let data = DummyNetworkManager.dustInfoResponseSuccess.data(using: .utf8)!
    xmlManager.decode(data) { (parsingType: DustAPIResponseMetadata?, error) in
      XCTAssertEqual(parsingType?.statusCode, DustAPIResultCode.success)
      XCTAssertNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_parse_headerResponse_error1() {
    let expect = expectation(description: "test")
    mockXMLDecoder.error = nil
    let data = DummyNetworkManager.dustInfoResponseApplicationError.data(using: .utf8)!
    xmlManager.decode(data) { (parsingType: DustAPIResponseMetadata?, error) in
      XCTAssertEqual(parsingType?.statusCode, DustAPIResultCode.applicationError)
      if let error = error as? DustAPIError {
        XCTAssertNotNil(error)
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_parse_headerResponse_error2() {
    let expect = expectation(description: "test")
    mockXMLDecoder.error = nil
    let data = DummyNetworkManager.dustInfoResponseDBError.data(using: .utf8)!
    xmlManager.decode(data) { (parsingType: DustAPIResponseMetadata?, error) in
      XCTAssertEqual(parsingType?.statusCode, DustAPIResultCode.dbError)
      if let error = error as? DustAPIError {
        XCTAssertNotNil(error)
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_parse_headerResponse_error3() {
    let expect = expectation(description: "test")
    mockXMLDecoder.error = nil
    let data = DummyNetworkManager.dustInfoResponseNoData.data(using: .utf8)!
    xmlManager.decode(data) { (parsingType: DustAPIResponseMetadata?, error) in
      XCTAssertEqual(parsingType?.statusCode, DustAPIResultCode.noData)
      if let error = error as? DustAPIError {
        XCTAssertNotNil(error)
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_parse_headerResponse_error4() {
    let expect = expectation(description: "test")
    mockXMLDecoder.error = nil
    let data = DummyNetworkManager.dustInfoResponseHTTPError.data(using: .utf8)!
    xmlManager.decode(data) { (parsingType: DustAPIResponseMetadata?, error) in
      XCTAssertEqual(parsingType?.statusCode, DustAPIResultCode.httpError)
      if let error = error as? DustAPIError {
        XCTAssertNotNil(error)
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_parse_headerResponse_error5() {
    let expect = expectation(description: "test")
    mockXMLDecoder.error = nil
    let data = DummyNetworkManager.dustInfoResponseServiceTimeOut.data(using: .utf8)!
    xmlManager.decode(data) { (parsingType: DustAPIResponseMetadata?, error) in
      XCTAssertEqual(parsingType?.statusCode, DustAPIResultCode.serviceTimeOut)
      if let error = error as? DustAPIError {
        XCTAssertNotNil(error)
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_parse_headerResponse_error6() {
    let expect = expectation(description: "test")
    mockXMLDecoder.error = nil
    let data = DummyNetworkManager.dustInfoResponseInvalidRequestParameter.data(using: .utf8)!
    xmlManager.decode(data) { (parsingType: DustAPIResponseMetadata?, error) in
      XCTAssertEqual(parsingType?.statusCode, DustAPIResultCode.invalidRequestParameter)
      if let error = error as? DustAPIError {
        XCTAssertNotNil(error)
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_parse_headerResponse_error7() {
    let expect = expectation(description: "test")
    mockXMLDecoder.error = nil
    let data = DummyNetworkManager.dustInfoResponseNoRequiredRequestParameter.data(using: .utf8)!
    xmlManager.decode(data) { (parsingType: DustAPIResponseMetadata?, error) in
      XCTAssertEqual(parsingType?.statusCode, DustAPIResultCode.noRequiredRequestParameter)
      if let error = error as? DustAPIError {
        XCTAssertNotNil(error)
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_parse_headerResponse_error8() {
    let expect = expectation(description: "test")
    mockXMLDecoder.error = nil
    let data = DummyNetworkManager.dustInfoResponseNoServiceOrDeprecated.data(using: .utf8)!
    xmlManager.decode(data) { (parsingType: DustAPIResponseMetadata?, error) in
      XCTAssertEqual(parsingType?.statusCode, DustAPIResultCode.noServiceOrDeprecated)
      if let error = error as? DustAPIError {
        XCTAssertNotNil(error)
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_parse_headerResponse_error9() {
    let expect = expectation(description: "test")
    mockXMLDecoder.error = nil
    let data = DummyNetworkManager.dustInfoResponseAccessDenied.data(using: .utf8)!
    xmlManager.decode(data) { (parsingType: DustAPIResponseMetadata?, error) in
      XCTAssertEqual(parsingType?.statusCode, DustAPIResultCode.accessDenied)
      if let error = error as? DustAPIError {
        XCTAssertNotNil(error)
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_parse_headerResponse_error10() {
    let expect = expectation(description: "test")
    mockXMLDecoder.error = nil
    let data = DummyNetworkManager.dustInfoResponseExceededRequestLimit.data(using: .utf8)!
    xmlManager.decode(data) { (parsingType: DustAPIResponseMetadata?, error) in
      XCTAssertEqual(parsingType?.statusCode, DustAPIResultCode.exceededRequestLimit)
      if let error = error as? DustAPIError {
        XCTAssertNotNil(error)
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_parse_headerResponse_error11() {
    let expect = expectation(description: "test")
    mockXMLDecoder.error = nil
    let data = DummyNetworkManager.dustInfoResponseUnregisteredServiceKey.data(using: .utf8)!
    xmlManager.decode(data) { (parsingType: DustAPIResponseMetadata?, error) in
      XCTAssertEqual(parsingType?.statusCode, DustAPIResultCode.unregisteredServiceKey)
      if let error = error as? DustAPIError {
        XCTAssertNotNil(error)
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_parse_headerResponse_error12() {
    let expect = expectation(description: "test")
    mockXMLDecoder.error = nil
    let data = DummyNetworkManager.dustInfoResponseExpiredServiceKey.data(using: .utf8)!
    xmlManager.decode(data) { (parsingType: DustAPIResponseMetadata?, error) in
      XCTAssertEqual(parsingType?.statusCode, DustAPIResultCode.expiredServiceKey)
      if let error = error as? DustAPIError {
        XCTAssertNotNil(error)
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_parse_headerResponse_error13() {
    let expect = expectation(description: "test")
    mockXMLDecoder.error = nil
    let data = DummyNetworkManager.dustInfoResponseUnregisteredDomainOfIPAddress.data(using: .utf8)!
    xmlManager.decode(data) { (parsingType: DustAPIResponseMetadata?, error) in
      XCTAssertEqual(parsingType?.statusCode, DustAPIResultCode.unregisteredDomainOfIPAddress)
      if let error = error as? DustAPIError {
        XCTAssertNotNil(error)
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_parse_headerResponse_error14() {
    let expect = expectation(description: "test")
    mockXMLDecoder.error = nil
    let data = DummyNetworkManager.dustInfoResponseDefault.data(using: .utf8)!
    xmlManager.decode(data) { (parsingType: DustAPIResponseMetadata?, error) in
      XCTAssertEqual(parsingType?.statusCode, DustAPIResultCode.default)
      if let error = error as? DustAPIError {
        XCTAssertNotNil(error)
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_parse_response_error() {
    let expect = expectation(description: "test")
    mockXMLDecoder.error = nil
    let data = DummyNetworkManager.dustInfoResponseNoData.data(using: .utf8)!
    xmlManager.decode(data) { (parsingType: DustAPIInfoResponse?, error) in
      XCTAssertNil(parsingType)
      if let error = error as? DustAPIError {
        XCTAssertNotNil(error)
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }

  func test_parse_xmlError1() {
    let expect = expectation(description: "test")
    mockXMLDecoder.error = XMLDeserializationError.implementationIsMissing(method: "")
    let data = DummyNetworkManager.dustInfoResponseSuccess.data(using: .utf8)!
    xmlManager.decode(data) { (parsingType: DustAPIInfoResponse?, error) in
      if let error = error as? XMLError {
        XCTAssertEqual(error, XMLError.implementationIsMissing(""))
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }

  func test_parse_xmlError2() {
    let expect = expectation(description: "test")
    let error = XMLDeserializationError.nodeIsInvalid(node: XMLIndexer(XMLElement(name: "", options: SWXMLHashOptions())))
    mockXMLDecoder.error = error
    let data = DummyNetworkManager.dustInfoResponseSuccess.data(using: .utf8)!
    xmlManager.decode(data) { (parsingType: DustAPIInfoResponse?, error) in
      if let error = error as? XMLError {
        XCTAssertEqual(error, XMLError.nodeIsInvalid(XMLIndexer(XMLElement(name: "", options: SWXMLHashOptions()))))
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_parse_xmlError3() {
    let expect = expectation(description: "test")
    let error = XMLDeserializationError.nodeHasNoValue
    mockXMLDecoder.error = error
    let data = DummyNetworkManager.dustInfoResponseSuccess.data(using: .utf8)!
    xmlManager.decode(data) { (parsingType: DustAPIInfoResponse?, error) in
      if let error = error as? XMLError {
        XCTAssertEqual(error, XMLError.nodeHasNoValue)
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_parse_xmlError4() {
    let expect = expectation(description: "test")
    let error = XMLDeserializationError.typeConversionFailed(type: "", element: XMLElement(name: "", options: SWXMLHashOptions()))
    mockXMLDecoder.error = error
    let data = DummyNetworkManager.dustInfoResponseSuccess.data(using: .utf8)!
    xmlManager.decode(data) { (parsingType: DustAPIInfoResponse?, error) in
      if let error = error as? XMLError {
        XCTAssertEqual(error, XMLError.typeConversionFailed("", XMLElement(name: "", options: SWXMLHashOptions())))
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_parse_xmlError5() {
    let expect = expectation(description: "test")
    let error = XMLDeserializationError.attributeDoesNotExist(element: XMLElement(name: "", options: SWXMLHashOptions()), attribute: "")
    mockXMLDecoder.error = error
    let data = DummyNetworkManager.dustInfoResponseSuccess.data(using: .utf8)!
    xmlManager.decode(data) { (parsingType: DustAPIInfoResponse?, error) in
      if let error = error as? XMLError {
        XCTAssertEqual(error, XMLError.attributeDoesNotExist(XMLElement(name: "", options: SWXMLHashOptions()), ""))
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_parse_xmlError6() {
    let expect = expectation(description: "test")
    let error = XMLDeserializationError.attributeDeserializationFailed(type: "", attribute: XMLAttribute(name: "", text: ""))
    mockXMLDecoder.error = error
    let data = DummyNetworkManager.dustInfoResponseSuccess.data(using: .utf8)!
    xmlManager.decode(data) { (parsingType: DustAPIInfoResponse?, error) in
      if let error = error as? XMLError {
        XCTAssertEqual(error, XMLError.attributeDeserializationFailed("", XMLAttribute(name: "", text: "")))
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
}
