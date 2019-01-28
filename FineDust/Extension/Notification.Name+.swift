//
//  Notification.Name+.swift
//  FineDust
//
//  Created by Presto on 25/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

extension Notification.Name {
  /// 관측소 조회 통신이 성공했을 때의 노티피케이션 이름.
  static let fetchObservatoryDidSuccess = Notification.Name("fetchObservatoryDidSuccess")
  /// 미세먼지 농도 조회 통신이 성공했을 때의 노티피케이션 이름.
  static let fetchFineDustConcentrationDidSuccess
    = Notification.Name("fetchFineDustConcentrationDidSuccess")
  /// 관측소 조회 통신이 실패했을 때의 노티피케이션 이름.
  static let fetchObservatoryDidError = Notification.Name("fetchObservatoryDidError")
  /// 미세먼지 농도 조회 통신이 실패했을 때의 노티피케이션 이름.
  static let fetchFineDustConcentrationDidError
    = Notification.Name("fetchFineDustConcentrationDidError")
}
