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
    XCTAssertEqual(grade?.description.localized, "Good")
  }
  
  func test_normal() {
    let grade = DustGrade(rawValue: 2)
    XCTAssertEqual(grade, DustGrade.normal)
    XCTAssertEqual(grade?.description.localized, "Normal")
  }
  
  func test_bad() {
    let grade = DustGrade(rawValue: 3)
    XCTAssertEqual(grade, DustGrade.bad)
    XCTAssertEqual(grade?.description.localized, "Bad")
  }
  
  func test_veryBad() {
    let grade = DustGrade(rawValue: 4)
    XCTAssertEqual(grade, DustGrade.veryBad)
    XCTAssertEqual(grade?.description.localized, "Very bad")
  }
  
  func test_default() {
    let grade = DustGrade(rawValue: 5)
    XCTAssertEqual(grade, DustGrade.default)
    XCTAssertEqual(grade?.description.localized, "Unknown")
  }
  
  func test_none() {
    let grade = DustGrade(rawValue: 0)
    XCTAssertNil(grade)
  }
}
