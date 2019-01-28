//
//  FineDustInfo.swift
//  FineDust
//
//  Created by Presto on 25/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// 미세먼지 정보를 담는 싱글톤 객체.
final class FineDustInfo {
  
  // MARK: Singleton Object
  
  static let shared = FineDustInfo()
  
  // MARK: Properties
  
  private var stationName: String = ""
  
  private var fineDustResponse: FineDustResponse? {
    // API 호출 후 미세먼지 응답을 싱글톤에 담을 때마다 노티피케이션을 쏴줌.
    didSet {
      NotificationCenter.default.post(
        name: .fetchFineDustConcentrationDidSuccess,
        object: nil,
        userInfo: ["data": fineDustResponse as Any]
      )
    }
  }
  
  /// 관측소.
  var observatory: String {
    return stationName
  }
  
  /// 미세먼지 응답.
  var response: FineDustResponse? {
    return fineDustResponse
  }
  
  // MARK: Methods
  
  /// 관측소 정보 설정.
  func set(observatory: String) {
    stationName = observatory
  }
  
  /// 응답 정보 설정.
  func set(fineDustResponse response: FineDustResponse?) {
    fineDustResponse = response
  }
}
