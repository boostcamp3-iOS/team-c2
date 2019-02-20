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
    XCTAssertEqual(grade?.description, "좋은 공기")
  }
  
  func test_normal() {
    let grade = DustGrade(rawValue: 2)
    XCTAssertEqual(grade, DustGrade.normal)
    XCTAssertEqual(grade?.description, "보통 공기")
  }
  
  func test_bad() {
    let grade = DustGrade(rawValue: 3)
    XCTAssertEqual(grade, DustGrade.bad)
    XCTAssertEqual(grade?.description, "나쁜 공기")
  }
  
  func test_veryBad() {
    let grade = DustGrade(rawValue: 4)
    XCTAssertEqual(grade, DustGrade.veryBad)
    XCTAssertEqual(grade?.description, "매우 나쁨")
  }
  
  func test_default() {
    let grade = DustGrade(rawValue: 5)
    XCTAssertEqual(grade, DustGrade.default)
    XCTAssertEqual(grade?.description, "기타")
  }
  
  func test_none() {
    let grade = DustGrade(rawValue: 0)
    XCTAssertNil(grade)
  }
}
