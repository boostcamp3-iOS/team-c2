//
//  GeoInfo.swift
//  FineDust
//
//  Created by Presto on 22/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// 위치 정보를 담는 싱글톤 객체.
final class LocationInfo {
  
  // MARK: Singleton Object
  
  /// 위치 정보의 싱글톤 객체
  static let shared = LocationInfo()
  
  // MARK: Private Initializer
  
  private init() { }
  
  // MARK: Properties

  private var xLocation: Double = 0
  
  private var yLocation: Double = 0
  
  private var addressInfo: String = ""
  
  /// X 좌표
  var x: Double {
    return xLocation
  }
  
  /// Y 좌표
  var y: Double {
    return yLocation
  }
  
  /// 주소
  var address: String {
    return addressInfo
  }
  
  // MARK: Methods
  
  /// 좌표 설정
  func set(x: Double, y: Double) {
    xLocation = x
    yLocation = y
  }
  
  /// 주소 설정
  func set(_ address: String) {
    addressInfo = address
  }
}
