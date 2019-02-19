//
//  TestHTTPError.swift
//  FineDustTests
//
//  Created by Presto on 19/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import Foundation
import XCTest

class TestHTTPError: XCTestCase {
  
  var error: HTTPError!
  
  func test_default() {
    error = HTTPError.default
    XCTAssertNotNil(error)
    XCTAssertEqual(HTTPError.default.localizedDescription, error.localizedDescription)
  }
}
