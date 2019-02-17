//
//  Grade.swift
//  FineDust
//
//  Created by Presto on 23/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

/// 미세먼지 API 응답에 의한 대기 등급 정의
enum DustGrade: Int {
  /// 등급에 따라 표현될 Label String.
  var description: String {
    switch self {
    case .good:
      return "좋은 공기"
    case .normal:
      return "보통 공기"
    case .bad:
      return "나쁜 공기"
    case .veryBad:
      return "매우 나쁨"
    case .default:
      return "기타"
    }
  }
  
  /// 좋음
  case good = 1
  
  /// 보통
  case normal
  
  /// 나쁨
  case bad
  
  /// 매우나쁨
  case veryBad
  
  /// 기타
  case `default`
}
