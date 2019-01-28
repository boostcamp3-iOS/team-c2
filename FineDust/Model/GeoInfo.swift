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
  
  /// 좌표 정보의 싱글톤 객체
  static let shared = GeoInfo()
  
  // MARK: Private Initializer
  
  private init() { }
  
  // MARK: Properties

  private var xLocation: Double = 0
  
  private var yLocation: Double = 0
  
  /// X 좌표
  var x: Double {
    return xLocation
  }
  
  /// Y 좌표
  var y: Double {
    return yLocation
  }
  
  // MARK: Methods
  
  /// 좌표 설정
  func setLocation(x: Double, y: Double) {
    xLocation = x
    yLocation = y
  }
}
