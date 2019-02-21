//
//  LastSavedData.swift
//  FineDust
//
//  Created by Presto on 15/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// 메인 뷰에 표시되는, 마지막으로 저장된 데이터
struct LastSavedData {
  
  /// 오늘 마신 미세먼지 농도.
  let todayFineDust: Int
  
  /// 오늘 마신 초미세먼지 농도.
  let todayUltrafineDust: Int
  
  /// 오늘 걸은 거리.
  let distance: Double
  
  /// 오늘 걸음수.
  let steps: Int
  
  /// 최근 주소.
  let address: String
  
  /// 최근 미세먼지 등급.
  let grade: Int
  
  /// 최근 미세먼지 농도.
  let recentFineDust: Int
  
  /// 일주일 미세먼지 농도.
  let weekFineDust: [Int]
  
  /// 일주일 초미세먼지 농도.
  let weekUltrafineDust: [Int]
}
