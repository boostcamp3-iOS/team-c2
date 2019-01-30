//
//  LocationManagerTest.swift
//  FineDustTests
//
//  Created by Presto on 30/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import XCTest
import CoreLocation

class LocationManagerTest: XCTestCase {
  
  var mockLocationManager = MockLocationManager()
  
  override func setUp() {
    mockLocationManager.status = .authorizedWhenInUse
  }
  
  override func tearDown() {
    
  }
  
  func testIsAuthorized() {
    XCTAssertTrue(mockLocationManager.status == .authorizedAlways)
  }
}
