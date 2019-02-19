//
//  TestNSObject+.swift
//  FineDustTests
//
//  Created by Presto on 19/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import Foundation
import XCTest

class TestNSObjectExtension: XCTestCase {
  
  func test_classNameToString() {
    XCTAssertEqual(StatisticsViewController.classNameToString, "StatisticsViewController")
  }
  
  func test_classNameToString2() {
    XCTAssertEqual(StatisticsViewController().classNameToString, "StatisticsViewController")
  }
}
