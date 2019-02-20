//
//  TestDateFormatter+.swift
//  FineDustTests
//
//  Created by Presto on 19/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import Foundation
import XCTest

class TestDateFormatterExtension: XCTestCase {
  
  var date: Date!
  
  override func setUp() {
    var componenets = DateComponents()
    componenets.year = 2019
    componenets.month = 2
    componenets.day = 19
    componenets.hour = 3
    componenets.minute = 3
    componenets.second = 3
    date = Calendar.current.date(from: componenets)
  }
  
  func test_dateAndTimeForDust() {
    let formatter = DateFormatter.dateAndTimeForDust
    XCTAssertEqual(formatter.string(from: date), "2019-02-19 03:03")
  }
  
  func  test_localizedDateWithDay() {
    let formatter = DateFormatter.localizedDateWithDay
    XCTAssertEqual(formatter.string(from: date), "2019년 2월 19일 화요일")
  }
  
  func  test_dateForDust() {
    let formatter = DateFormatter.dateForDust
    XCTAssertEqual(formatter.string(from: date), "2019-02-19")
  }
  
  func  test_hour() {
    let formatter = DateFormatter.hour
    XCTAssertEqual(formatter.string(from: date), "03")
  }
  
  func  test_day() {
    let formatter = DateFormatter.day
    XCTAssertEqual(formatter.string(from: date), "19")
  }
}
