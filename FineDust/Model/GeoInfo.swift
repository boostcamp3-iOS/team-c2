//
//  GeoInfo.swift
//  FineDust
//
//  Created by Presto on 22/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// 좌표 정보를 담는 싱글톤 객체.
final class GeoInfo {
  
  // MARK: Singleton Object
  
  static let shared = GeoInfo()
  
  // MARK: Property

  private var xLocation: Double = 0
  
  private var yLocation: Double = 0
  
  private var stationName: String = ""
  
  var x: Double {
    return xLocation
  }
  
  var y: Double {
    return yLocation
  }
  
  var observatory: String {
    return stationName
  }
  
  // MARK: Method
  
  func setLocation(x: Double, y: Double) {
    xLocation = x
    yLocation = y
  }
  
  func setObservatory(_ observatory: String) {
    stationName = observatory
  }
}
