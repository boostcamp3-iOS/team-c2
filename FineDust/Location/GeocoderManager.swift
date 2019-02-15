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
final class GeocoderManager: GeocoderManagerType {
  
  // MARK: Singleton Object
  
  /// 지오코딩 매니저의 싱글톤 객체.
  static let shared = GeocoderManager()
  
  private init() { }
  
  func requestAddress(_ location: CLLocation,
                      completion: @escaping (String?, Error?) -> Void) {
    CLGeocoder()
      .reverseGeocodeLocation(location,
                              preferredLocale: .korea) { placemarks, error in
                                if let error = error {
                                  completion(nil, error)
                                  return
                                }
                                guard let placemark = placemarks?.first else { return }
                                let locality = placemark.locality ?? ""
                                // 도로명과 번지를 잘라 도로명만 취함
                                let name = placemark.name?.components(separatedBy: " ").first ?? ""
                                let address = "\(locality) \(name)"
                                completion(address, nil)
    }
  }
}
