//
//  User+.swift
//  FineDust
//
//  Created by Presto on 25/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import CoreData
import Foundation

/// `User` Entity Attribute 상수 정리
extension User {
  
  /// 최근 접속 날짜 Attribute.
  static let lastAccessedDate = "lastAccessedDate"
  
  /// 오늘의 미세먼지 흡입량 Attribute.
  static let todayFineDust = "todayFineDust"
  
  /// 오늘의 초미세먼지 흡입량 Attribute.
  static let todayUltrafineDust = "todayUltrafineDust"
  
  /// 현재까지 걸은 거리 Attribute.
  static let distance = "distance"
  
  /// 현재까지 걸음 수 Attribute.
  static let steps = "steps"
  
  /// 최근 호출한 주소 Attribute.
  static let address = "address"
  
  /// 최근 호출한 미세먼지 등급 Attribute.
  static let grade = "grade"
  
  /// 최근 호출한 미세먼지 농도 Attribute.
  static let recentFineDust = "recentFineDust"
  
  /// 일주일의 미세먼지 흡입량 Attribute.
  static let weekFineDust = "weekFineDust"
  
  /// 일주일의 미세먼지 흡입량 Attribute.
  static let weekUltrafineDust = "weekUltrafineDust"
}
