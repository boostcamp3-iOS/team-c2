//
//  Grade.swift
//  FineDust
//
//  Created by Presto on 23/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

/// 미세먼지 API 응답에 의한 대기 등급 정의
enum DustGrade: Int {
  
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
