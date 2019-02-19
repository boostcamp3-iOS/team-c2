//
//  TestDate+.swift
//  FineDustTests
//
//  Created by Presto on 19/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import Foundation
import XCTest

class TestDateExtension: XCTestCase {
  
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
  
  func test_before1() {
    var componenets = DateComponents()
    componenets.year = 2019
    componenets.month = 2
    componenets.day = 18
    componenets.hour = 3
    componenets.minute = 3
    componenets.second = 3
    let newDate = Calendar.current.date(from: componenets)
    XCTAssertEqual(date.before(days: 1), newDate)
  }
  
  func test_before2() {
    XCTAssertEqual(Date.before(days: 1, since: date), date.before(days: 1))
  }
  
  func test_after1() {
    var componenets = DateComponents()
    componenets.year = 2019
    componenets.month = 2
    componenets.day = 20
    componenets.hour = 3
    componenets.minute = 3
    componenets.second = 3
    let newDate = Calendar.current.date(from: componenets)
    XCTAssertEqual(date.after(days: 1), newDate)
  }
  
  func test_after2() {
    XCTAssertEqual(Date.after(days: 1, since: date), date.after(days: 1))
  }
  
  func test_isToday() {
    XCTAssertEqual(Date().isToday, true)
  }
}
