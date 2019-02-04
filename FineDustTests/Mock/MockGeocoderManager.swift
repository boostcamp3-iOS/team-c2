//
//  MockGeocoderManager.swift
//  FineDustTests
//
//  Created by Presto on 31/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import CoreLocation

class MockGeocoderManager: GeocoderManagerType {
  func fetchAddress(_ location: CLLocation, completion: @escaping (String?, Error?) -> Void) {
    
  }
  
  var error: Error?
  
  var placemarks: [CLPlacemark]?
  
  func fetchAddress(_ location: CLLocation,
                    preferredLocale locale: Locale?,
                    completionHandler: @escaping ([CLPlacemark]?, Error?) -> Void) {
    completionHandler(placemarks, error)
  }
}
