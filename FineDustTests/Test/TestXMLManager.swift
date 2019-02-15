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
  
  func test_parse_headerResponse_error() {
    let expect = expectation(description: "test")
    mockXMLDecoder.error = nil
    let data = DummyNetworkManager.dustInfoResponseNoData.data(using: .utf8)!
    xmlManager.decode(data) { (parsingType: ResponseHeader?, error) in
      XCTAssertNil(parsingType)
      if let error = error as? DustError {
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
    xmlManager.decode(data) { (parsingType: DustResponse?, error) in
      XCTAssertNil(parsingType)
      if let error = error as? DustError {
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
    xmlManager.decode(data) { (parsingType: DustResponse?, error) in
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
    xmlManager.decode(data) { (parsingType: DustResponse?, error) in
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
    xmlManager.decode(data) { (parsingType: DustResponse?, error) in
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
    xmlManager.decode(data) { (parsingType: DustResponse?, error) in
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
    xmlManager.decode(data) { (parsingType: DustResponse?, error) in
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
    xmlManager.decode(data) { (parsingType: DustResponse?, error) in
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
