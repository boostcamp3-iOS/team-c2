//
//  TestServiceErrorType.swift
//  FineDustTests
//
//  Created by Presto on 19/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import Foundation
import XCTest
import CoreLocation

class TestServiceErrorType: XCTestCase {
  
  func test_httpError() {
    let error: ServiceErrorType = HTTPError.default
    XCTAssertEqual(error.localizedDescription, HTTPError.default.localizedDescription)
  }
  
  func test_dustError() {
    let error: ServiceErrorType = DustAPIError.default
    XCTAssertEqual(error.localizedDescription, DustAPIError.default.localizedDescription)
  }
  
  func test_healthKitError() {
    let error: ServiceErrorType = HealthKitError.queryNotValid
    XCTAssertEqual(error.localizedDescription, HealthKitError.queryNotValid.localizedDescription)
  }
}
