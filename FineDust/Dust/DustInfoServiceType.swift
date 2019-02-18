//
//  DustServiceType.swift
//  FineDust
//
//  Created by Presto on 01/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// 미세먼지 정보 서비스 프로토콜.
protocol DustInfoServiceType: class {
  
  /// 최근 시간의 미세먼지 관련 정보 요청.
  func requestRecentTimeInfo(_ completion: @escaping (RecentDustInfo?, Error?) -> Void)
  
  /// 하루의 미세먼지 관련 정보를 요청하고 시간대별 미세먼지 값과 초미세먼지 값을 산출.
  func requestDayInfo(_ completion: @escaping (HourIntakePair?, HourIntakePair?, Error?) -> Void)
  
  /// 특정 날짜 내의 관련 정보를 요청하고 시간대별 미세먼지 값과 초미세먼지 값을 산출.
  func requestDayInfo(
    from startDate: Date,
    to endDate: Date,
    completion: @escaping (DateHourIntakePair?, DateHourIntakePair?, Error?) -> Void
  )
}
