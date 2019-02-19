//
//  TestFDCountingLabel.swift
//  FineDustTests
//
//  Created by Presto on 19/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import Foundation
import XCTest

class TestFDCountingLabel: XCTestCase {
  
  let label = FDCountingLabel()
  
  func test_setNoValue() {
    label.setNoValue()
    XCTAssertEqual(label.text!, "-")
  }
  
  func test_countFromZero() {
    let expect = expectation(description: "test")
    label.countFromZero(to: 3, unit: .percent, interval: 0.001)
    _ = XCTWaiter.wait(for: [expect], timeout: 1)
    XCTAssertEqual(label.text!, "3%")
  }
}
