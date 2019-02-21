//
//  Grade.swift
//  FineDust
//
//  Created by Presto on 23/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

/// 미세먼지 API 응답에 의한 대기 등급 정의
enum DustGrade: Int, CustomStringConvertible {
  
  /// 좋음
  case good = 1
  
  /// 보통
  case normal
  
  /// 나쁨
  case bad
  
  /// 매우나쁨
  case veryBad
  
  /// 알 수 없음
  case `default`
  
  var description: String {
    switch self {
    case .good:
      return "좋음".localized
    case .normal:
      return "보통".localized
    case .bad:
      return "나쁨".localized
    case .veryBad:
      return "매우 나쁨".localized
    case .default:
      return "알 수 없음".localized
    }
  }
}
