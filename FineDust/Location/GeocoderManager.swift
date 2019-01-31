//
//  GeocoderManager.swift
//  FineDust
//
//  Created by Presto on 31/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import CoreLocation
import Foundation

/// 지오코딩 매니저.
final class GeocoderManager {
  
  // MARK: Singleton Object
  
  /// 지오코딩 매니저의 싱글톤 객체.
  static let shared = GeocoderManager()
  
  private init() { }
}

// MARK: - GeocoderManagerType 구현

extension GeocoderManager: GeocoderManagerType {
  func fetchAddress(_ location: CLLocation,
                    completion: @escaping (String?, Error?) -> Void) {
    CLGeocoder().reverseGeocodeLocation(location, preferredLocale: Locale(identifier: "ko_KR")) { placemarks, error in
      if let error = error {
        completion(nil, error)
        return
      }
      guard let placemark = placemarks?.first else { return }
      let administrativeArea = placemark.administrativeArea ?? ""
      let locality = placemark.locality ?? ""
      let name = placemark.name ?? ""
      let address = "\(administrativeArea) \(locality) \(name)"
      completion(address, nil)
    }
  }
}
