//
//  LocationManagerType.swift
//  FineDust
//
//  Created by Presto on 31/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import CoreLocation

protocol LocationManagerType: class {
  
  var authorizationStatus: CLAuthorizationStatus { get }
  
  var authorizationDidChange: ((CLAuthorizationStatus) -> Void)? { get }
  
  var locationDidUpdate: ((CLLocation?) -> Void)? { get }
  
  var errorHandler: ((Error) -> Void)? { get }
  
  func requestAuthorization()
  
  func startUpdatingLocation()
  
  func stopUpdatingLocation()
}
