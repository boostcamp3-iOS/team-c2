//
//  LocationManager.swift
//  FineDust
//
//  Created by Presto on 30/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import CoreLocation
import Foundation

protocol LocationManagerType: class {
  
  var authorizationChangeHandler: ((CLAuthorizationStatus) -> Void)? { get set }
  
  var updateLocationHandler: ((CLLocation) -> Void)? { get set }
  
  var errorHandler: ((Error) -> Void)? { get set }
  
  func configure(_ configureHandler: @escaping (LocationManagerType) -> Void)
  
  func startUpdatingLocation()
  
  func requestAuthorization()
}

class LocationManager: NSObject {
  
  static let shared = LocationManager()
  
  private var _authorizationChangeHandler: ((CLAuthorizationStatus) -> Void)?
  
  private var _updateLocationHandler: ((CLLocation) -> Void)?
  
  private var _errorHandler: ((Error) -> Void)?
  
  private let locationManager: CLLocationManager = {
    let manager = CLLocationManager()
    manager.desiredAccuracy = kCLLocationAccuracyBest
    manager.distanceFilter = kCLDistanceFilterNone
    return manager
  }()
  
  private override init() {
    super.init()
    locationManager.delegate = self
  }
}

extension LocationManager: LocationManagerType {
  
  var authorizationChangeHandler: ((CLAuthorizationStatus) -> Void)? {
    get {
      return _authorizationChangeHandler
    }
    set {
      _authorizationChangeHandler = newValue
    }
  }
  
  var updateLocationHandler: ((CLLocation) -> Void)? {
    get {
      return _updateLocationHandler
    }
    set {
      _updateLocationHandler = newValue
    }
  }
  
  var errorHandler: ((Error) -> Void)? {
    get {
      return _errorHandler
    }
    set {
      _errorHandler = newValue
    }
  }
  
  func configure(_ configureHandler: @escaping (LocationManagerType) -> Void) {
    configureHandler(self)
  }
  
  func requestAuthorization() {
    locationManager.requestAlwaysAuthorization()
  }
  
  func startUpdatingLocation() {
    locationManager.startUpdatingLocation()
  }
}

extension LocationManager: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.first else { return }
    updateLocationHandler?(location)
    locationManager.stopUpdatingLocation()
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    errorHandler?(error)
  }
  
  func locationManager(_ manager: CLLocationManager,
                       didChangeAuthorization status: CLAuthorizationStatus) {
    authorizationChangeHandler?(status)
  }
}
