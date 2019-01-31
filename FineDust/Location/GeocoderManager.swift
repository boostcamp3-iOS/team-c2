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
                    preferredLocale locale: Locale?,
                    completionHandler: @escaping ([CLPlacemark]?, Error?) -> Void) {
    CLGeocoder().reverseGeocodeLocation(location,
                                        preferredLocale: Locale(identifier: "ko_KR"),
                                        completionHandler: completionHandler)
  }
}
