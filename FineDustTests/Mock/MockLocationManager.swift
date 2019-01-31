//
//  MockLocationManager.swift
//  FineDustTests
//
//  Created by Presto on 30/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import Foundation
import CoreLocation

class MockLocationManager: LocationManagerType {
  
  var error: Error?
  
  var status: CLAuthorizationStatus = .authorizedAlways
  
  var location: CLLocation = CLLocation(latitude: 0.1, longitude: 0.1)
  
  // MARK: - 프로토콜 구현부
  
  var authorizationChangingHandler: ((CLAuthorizationStatus) -> Void)?
  
  var locationUpdatingHandler: ((CLLocation) -> Void)?
  
  var errorHandler: ((Error) -> Void)?
  
  func configure(_ configurationHandler: @escaping (LocationManagerType) -> Void) {
    
  }
  
  func requestAuthorization() {
    
  }
  
  func startUpdatingLocation() {
    
  }
  
  func stopUpdatingLocation() {
    
  }
}
