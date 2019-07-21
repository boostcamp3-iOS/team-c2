//
//  TestTypealias.swift
//  FineDustTests
//
//  Created by Presto on 19/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import Foundation
import XCTest

class TestTypealias: XCTestCase {
  
  func test_sortedByHour_ascending() {
    let dict: HourIntakePair = [.zero: 0, .one: 1]
    let sorted = dict.sortByHour()
    let compared: [(key: Hour, value: Int)] = [(key: .zero, value: 0), (key: .one, value: 1)]
    for index in sorted.indices {
      let sortedElement = sorted[index]
      let comparedElement = compared[index]
      XCTAssertEqual(sortedElement.key, comparedElement.key)
      XCTAssertEqual(sortedElement.value, comparedElement.value)
    }
  }
  
  func test_sortedByHour_descending() {
    let dict: HourIntakePair = [.zero: 0, .one: 1]
    let sorted = dict.sortByHour(isAscending: false)
    let compared: [(key: Hour, value: Int)] = [(key: .one, value: 1), (key: .zero, value: 0)]
    for index in sorted.indices {
      let sortedElement = sorted[index]
      let comparedElement = compared[index]
      XCTAssertEqual(sortedElement.key, comparedElement.key)
      XCTAssertEqual(sortedElement.value, comparedElement.value)
    }
  }
  
  func test_sortedByDate_ascending() {
    let referenceDate = Date()
    let dict: DateHourIntakePair = [referenceDate.before(days: 1): [.zero: 0, .one: 1], referenceDate.before(days: 2): [.zero: 0, .one: 1]]
    let sorted = dict.sort()
    let compared: [(key: Date, value: HourIntakePair)] = [(key: referenceDate.before(days: 2), value: [.zero: 0, .one: 1]), (key: referenceDate.before(days: 1), value: [.zero: 0, .one: 1])]
    for index in sorted.indices {
      let sortedElement = sorted[index]
      let comparedElement = compared[index]
      XCTAssertEqual(sortedElement.key, comparedElement.key)
      XCTAssertEqual(sortedElement.value, comparedElement.value)
    }
  }
  
  func test_sortedByDate_descending() {
    let referenceDate = Date()
    let dict: DateHourIntakePair = [referenceDate.before(days: 1): [.zero: 0, .one: 1], referenceDate.before(days: 2): [.zero: 0, .one: 1]]
    let sorted = dict.sort(byAscending: false)
    let compared: [(key: Date, value: HourIntakePair)] = [(key: referenceDate.before(days: 1), value: [.zero: 0, .one: 1]), (key: referenceDate.before(days: 2), value: [.zero: 0, .one: 1])]
    for index in sorted.indices {
      let sortedElement = sorted[index]
      let comparedElement = compared[index]
      XCTAssertEqual(sortedElement.key, comparedElement.key)
      XCTAssertEqual(sortedElement.value, comparedElement.value)
    }
  }
}
