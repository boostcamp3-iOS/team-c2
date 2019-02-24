//
//  TestIntakeGrade.swift
//  FineDustTests
//
//  Created by Presto on 19/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import Foundation
import XCTest

class TestIntakeGrade: XCTestCase {
  
  var grade: IntakeGrade!
  
  func test_veryGood() {
    grade = IntakeGrade(intake: 40)
    XCTAssertEqual(grade, .veryGood)
    XCTAssertEqual(grade.iconName, Asset.dustIcon1.name)
    XCTAssertEqual(grade.imageName, Asset.dust1.name)
  }
  
  func test_good() {
    grade = IntakeGrade(intake: 90)
    XCTAssertEqual(grade, .good)
    XCTAssertEqual(grade.iconName, Asset.dustIcon2.name)
    XCTAssertEqual(grade.imageName, Asset.dust2.name)
  }
  
  func test_normal() {
    grade = IntakeGrade(intake: 140)
    XCTAssertEqual(grade, .normal)
    XCTAssertEqual(grade.iconName, Asset.dustIcon3.name)
    XCTAssertEqual(grade.imageName, Asset.dust3.name)
  }
  
  func test_bad() {
    grade = IntakeGrade(intake: 190)
    XCTAssertEqual(grade, .bad)
    XCTAssertEqual(grade.iconName, Asset.dustIcon4.name)
    XCTAssertEqual(grade.imageName, Asset.dust4.name)
  }
  
  func test_veryBad() {
    grade = IntakeGrade(intake: 240)
    XCTAssertEqual(grade, .veryBad)
    XCTAssertEqual(grade.iconName, Asset.dustIcon5.name)
    XCTAssertEqual(grade.imageName, Asset.dust5.name)
  }
  
  func test_default() {
    grade = IntakeGrade(intake: -1)
    XCTAssertEqual(grade, .default)
    XCTAssertEqual(grade.iconName, "")
    XCTAssertEqual(grade.imageName, "")
  }
}
