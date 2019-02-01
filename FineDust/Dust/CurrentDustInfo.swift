//
//  CurrentDustInfo.swift
//  FineDust
//
//  Created by Presto on 01/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// 현재 미세먼지 관련 정보 정의.
struct CurrentDustInfo {
  
  /// 현재 미세먼지 값.
  let currentFineDustValue: Int
  
  /// 현재 초미세먼지 값.
  let currentUltraFineDustValue: Int
  
  /// 현재 미세먼지 등급.
  let currentFineDustGrade: DustGrade
  
  /// 현재 초미세먼지 등급.
  let currentUltraFineDustGrade: DustGrade
  
  /// 최신 정보 갱신 시간.
  let recentUpdatingTime: Date
}
