//
//  TestGeocoderManager.swift
//  FineDustTests
//
//  Created by Presto on 19/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import Foundation
import XCTest
import CoreLocation

class TestGeocoderManager: XCTestCase {
  
  let geocoderManager = GeocodeManager.shared
  
//  func test_requestAddress() {
//    let expect = expectation(description: "test")
//    geocoderManager.requestAddress(.init(latitude: 37.4969, longitude: 127.0284)) { address, error in
//      defer { expect.fulfill() }
//      XCTAssertEqual(address, "강남구 강남대로")
//      XCTAssertNil(error)
//    }
//    waitForExpectations(timeout: 5, handler: nil)
//  }
  
  func test_requestAddress_error() {
    let expect = expectation(description: "test")
    geocoderManager.requestAddress(.init(latitude: -1234, longitude: -1234)) { address, error in
      XCTAssertNil(address)
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
}
