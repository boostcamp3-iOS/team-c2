//
//  GeocoderManagerType.swift
//  FineDust
//
//  Created by Presto on 31/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import CoreLocation
import Foundation

/// 지오코딩 매니저 프로토콜.
protocol GeocoderManagerType: class {
  
  /// 위경도를 주소로 바꿈.
  func fetchAddress(_ location: CLLocation, completion: @escaping (String?, Error?) -> Void)
}
