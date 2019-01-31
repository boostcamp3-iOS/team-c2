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
  
  var status: CLAuthorizationStatus?
  
  var location: CLLocation?
  
  var authorizationChangeHandler: ((CLAuthorizationStatus) -> Void)?
  
  var locationUpdateHandler: ((CLLocation) -> Void)?
  
  var errorHandler: ((Error) -> Void)?
  
  func configure(_ configureHandler: @escaping (LocationManagerType) -> Void) {
    
  }
  
  func startUpdatingLocation() {
    
  }
  
  func requestAuthorization() {
    
  }
}
