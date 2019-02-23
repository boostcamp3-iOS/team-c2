//
//  TestDustGrade.swift
//  FineDustTests
//
//  Created by Presto on 19/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import Foundation
import XCTest

class TestDustGrade: XCTestCase {
  
  func test_good() {
    let grade = DustGrade(rawValue: 1)
    XCTAssertEqual(grade, DustGrade.good)
    XCTAssertEqual(grade?.description, L10n.good)
  }
  
  func test_normal() {
    let grade = DustGrade(rawValue: 2)
    XCTAssertEqual(grade, DustGrade.normal)
    XCTAssertEqual(grade?.description, L10n.normal)
  }
  
  func test_bad() {
    let grade = DustGrade(rawValue: 3)
    XCTAssertEqual(grade, DustGrade.bad)
    XCTAssertEqual(grade?.description, L10n.bad)
  }
  
  func test_veryBad() {
    let grade = DustGrade(rawValue: 4)
    XCTAssertEqual(grade, DustGrade.veryBad)
    XCTAssertEqual(grade?.description, L10n.veryBad)
  }
  
  func test_default() {
    let grade = DustGrade(rawValue: 5)
    XCTAssertEqual(grade, DustGrade.default)
    XCTAssertEqual(grade?.description, L10n.unknown)
  }
  
  func test_none() {
    let grade = DustGrade(rawValue: 0)
    XCTAssertNil(grade)
  }
}
