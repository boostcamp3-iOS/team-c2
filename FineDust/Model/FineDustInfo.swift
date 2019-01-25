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
    didSet {
      NotificationCenter.default.post(
        name: .fetchFineDustConcentrationDidSuccess,
        object: nil,
        userInfo: ["data": fineDustResponse]
      )
    }
  }
  
  var observatory: String {
    return stationName
  }
  
  var response: FineDustResponse? {
    return fineDustResponse
  }
  
  // MARK: Methods
  
  func set(observatory: String) {
    stationName = observatory
  }
  
  func set(fineDustResponse response: FineDustResponse?) {
    fineDustResponse = response
  }
}
