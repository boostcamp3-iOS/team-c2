//
//  APIServiceTest.swift
//  FineDustTests
//
//  Created by Presto on 31/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import XCTest
import Foundation

class APIServiceTest: XCTestCase {
  
  var apiService: APIService!
  
  var mockLocationManager = MockLocationManager()
  
  var mockGeocoderManager = MockGeocoderManager()
  
  override func setUp() {
    apiService = APIService(locationManager: mockLocationManager, geocoderManager: mockGeocoderManager)
  }
  
  override func tearDown() {
    
  }
  
  func test_fetchCurrentObservatory() {
    var errorValue: Error? = nil
    var observatoryValue: String? = nil
    apiService.fetchCurrentObservatory { observatory, error in
      observatoryValue = observatory
      errorValue = error
      self.expectation(description: "observatory").fulfill()
    }
    XCTAssertNotNil(errorValue)
    XCTAssertEqual(observatoryValue, "강남대로")
  }
  
  func test_fetchFineDust() {
    
  }
}
