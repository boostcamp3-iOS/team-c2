//
//  TestDustStatusCode.swift
//  FineDustTests
//
//  Created by Presto on 19/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import Foundation
import XCTest

class TestDustStatusCode: XCTestCase {
  
  var code: DustStatusCode!
  
  func test_success_error() {
    code = DustStatusCode.success
    XCTAssertNil(code.error)
  }
}
