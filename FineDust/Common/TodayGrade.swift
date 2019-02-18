//
//  TodayGrade.swift
//  FineDust
//
//  Created by 이재은 on 18/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// 오늘 미세먼지 마신 양에 대한 등급.
enum TodayGrade: Int {
  
  /// 가장 좋은 등급 1
  case good = 1
  
  /// 보통 등급 2
  case soso
  
  /// 나쁜 등급 3
  case bad
  
  /// 더 나쁜 등급 4
  case worse

  /// 가장 나쁜 등급 5
  case evil
}
