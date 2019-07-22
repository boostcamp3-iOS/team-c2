//
//  TestHTTPStatusCode.swift
//  FineDustTests
//
//  Created by Presto on 19/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import Foundation
import XCTest

class TestHTTPStatusCode: XCTestCase {
  
  var code: StatusCode!
  
  func test_error_success() {
    code = StatusCode.success
    XCTAssertNil(code.error)
  }
  
  func test_error_default() {
    code = StatusCode.default
    XCTAssertNotNil(code.error)
    XCTAssertEqual(code.error?.localizedDescription, StatusCode.default.error?.localizedDescription)
  }
}
