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
  
  /// 최근 시간의 미세먼지 관련 정보 fetch.
  func fetchRecentTimeInfo(_ completion: @escaping (RecentDustInfo?, Error?) -> Void)
  
  /// 하루의 미세먼지 관련 정보를 fetch하고 시간대별 미세먼지 값과 초미세먼지 값을 산출.
  func fetchInfo(_ completion: @escaping (HourIntakePair?, HourIntakePair?, Error?) -> Void)
  
  /// 특정 날짜부터 특정 날짜까지의 미세먼지 관련 정보를 fetch하고 시간대별 미세먼지 값과 초미세먼지 값을 산출.
  func fetchInfo(from startDate: Date,
                 to endDate: Date,
                 completion: @escaping (DateHourIntakePair?, DateHourIntakePair?, Error?) -> Void)
}
