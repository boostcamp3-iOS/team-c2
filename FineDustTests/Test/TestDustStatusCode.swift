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
  
  var code: DustAPIResultCode!
  
  func test_success_error() {
    code = DustAPIResultCode.success
    XCTAssertNil(code.error)
  }
}
