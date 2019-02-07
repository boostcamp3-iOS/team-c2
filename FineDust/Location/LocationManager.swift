//
//  LocationManager.swift
//  FineDust
//
//  Created by Presto on 30/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import CoreLocation
import Foundation

/// Location Manager
final class LocationManager: NSObject {
  
  // MARK: Singleton Object
  
  /// Location Manager의 싱글톤 객체.
  static let shared = LocationManager()
  
  // MARK: Private Property

  /// Core Location의 Location Manager
  private let locationManager: CLLocationManager = {
    let manager = CLLocationManager()
    manager.desiredAccuracy = kCLLocationAccuracyBest
    manager.distanceFilter = kCLDistanceFilterNone
    return manager
  }()
  
  // MARK: Private Initializer
  
  private override init() {
    super.init()
    locationManager.delegate = self
  }
}

// MARK: - LocationManagerType 구현

extension LocationManager: LocationManagerType {

  func requestAuthorization() {
    locationManager.requestAlwaysAuthorization()
  }
  
  func startUpdatingLocation() {
    locationManager.startUpdatingLocation()
  }
  
  func stopUpdatingLocation() {
    locationManager.stopUpdatingLocation()
  }
}

// MARK: - CLLocationManagerDelegate 구현

extension LocationManager: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.first else { return }
    locationUpdatingHandler?(location)
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    errorHandler?(error)
  }
  
  func locationManager(_ manager: CLLocationManager,
                       didChangeAuthorization status: CLAuthorizationStatus) {
    authorizationChangingHandler?(status)
  }
}
