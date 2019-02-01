//
//  FineDustInfo.swift
//  FineDust
//
//  Created by Presto on 25/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// 미세먼지 정보를 담는 싱글톤 객체.
final class SharedInfo {
  
  // MARK: Singleton Object
  
  static let shared = SharedInfo()
  
  // MARK: Private Initializer
  
  private init() { }
  
  // MARK: Properties
  
  private var _x: Double = 0
  
  private var _y: Double = 0
  
  private var _address: String = ""
  
  private var _observatory: String = ""
  
  var x: Double {
    return _x
  }
  
  var y: Double {
    return _y
  }
  
  var address: String {
    return _address
  }
  
  /// 관측소.
  var observatory: String {
    return _observatory
  }

  // MARK: Methods
  
  func set(x: Double, y: Double) {
    _x = x
    _y = y
  }
  
  func set(address: String) {
    _address = address
  }
  
  /// 관측소 정보 설정.
  func set(observatory: String) {
    _observatory = observatory
  }
}
