//
//  TestUIColor+.swift
//  FineDustTests
//
//  Created by Presto on 19/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import Foundation
import XCTest

class TestUIColorExtension: XCTestCase {
  
  func test_convenienceInit1() {
    let color = UIColor(red: 1.1, green: 1.1, blue: 1.1)
    XCTAssertEqual(color, UIColor(red: 1.1 / 255, green: 1.1 / 255, blue: 1.1 / 255, alpha: 1))
  }
  
  func test_convenienceInit2() {
    let color = UIColor(rgb: 1.1)
    XCTAssertEqual(color, UIColor(red: 1.1 / 255, green: 1.1 / 255, blue: 1.1 / 255, alpha: 1))
  }
  
  func test_convenienceInit3() {
    let color = UIColor(red: 0x01, green: 0x01, blue: 0x01)
    XCTAssertEqual(color, UIColor(red: CGFloat(0x01) / 255, green: CGFloat(0x01) / 255, blue: CGFloat(0x01) / 255, alpha: 1))
  }
  
  func test_convenienceInit4() {
    let color = UIColor(rgb: 0x01)
    XCTAssertEqual(color, UIColor(red: 0x01 >> 16 & 0xff, green: 0x01 >> 8 & 0xff, blue: 0x01 & 0xff))
  }
}
