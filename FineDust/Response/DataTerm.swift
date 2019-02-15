//
//  DataTerm.swift
//  FineDust
//
//  Created by Presto on 23/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

/// 실시간 미세먼지 정보 얻어오는 기간 정의
enum DataTerm: String {
  
  /// 일간.
  ///
  /// 이 경우 `numberOfRows`는 최대 24이다.
  case daily
  
  /// 월간.
  case month
}
