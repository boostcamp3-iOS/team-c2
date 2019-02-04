//
//  CurrentDustInfo.swift
//  FineDust
//
//  Created by Presto on 01/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// 최신 미세먼지 관련 정보 정의.
struct RecentDustInfo {
  
  /// 최신 미세먼지 값.
  let fineDustValue: Int
  
  /// 최신 초미세먼지 값.
  let ultrafineDustValue: Int
  
  /// 최신 미세먼지 등급.
  let fineDustGrade: DustGrade
  
  /// 최신 초미세먼지 등급.
  let ultrafineDustGrade: DustGrade
  
  /// 최신 정보 갱신 시간.
  let updatingTime: Date
}
