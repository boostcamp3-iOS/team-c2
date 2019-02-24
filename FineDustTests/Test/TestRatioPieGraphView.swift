//
//  TestRatioPieGraphView.swift
//  FineDustTests
//
//  Created by Presto on 20/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import Foundation
import XCTest

class TestGraphView: XCTestCase {
  
  let valueGraphView: ValueGraphView! = UIView.instantiate(fromXib: ValueGraphView.classNameToString) as? ValueGraphView
  let pieGraphView = RatioPieGraphView()
  let stickGraphView: RatioStickGraphView! = UIView.instantiate(fromXib: RatioStickGraphView.classNameToString) as? RatioStickGraphView
  
  override func setUp() {
    
  }
  
  func test_setState() {
    valueGraphView.awakeFromNib()
    valueGraphView.reloadGraphView()
    pieGraphView.setState(ratio: 10, endAngle: 10)
    stickGraphView.awakeFromNib()
    stickGraphView.setState(average: 10, today: 10)
  }
}
