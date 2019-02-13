//
//  MockDustInfoService.swift
//  FineDustTests
//
//  Created by Presto on 04/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import Foundation

class MockDustInfoService: DustInfoServiceType {
  
  var recentDustInfo: RecentDustInfo?
  
  var fineDustHourlyValue: HourIntakePair?
  
  var ultrafineDustHourlyValue: HourIntakePair?
  
  var fineDustHourlyValuePerDate: DateHourIntakePair?
  
  var ultrafineDustHourlyValuePerDate: DateHourIntakePair?
  
  var error: Error?
  
  func requestRecentTimeInfo(_ completion: @escaping (RecentDustInfo?, Error?) -> Void) {
    completion(recentDustInfo, error)
  }
  
  func requestDayInfo(_ completion: @escaping (HourIntakePair?, HourIntakePair?, Error?) -> Void) {
    completion(fineDustHourlyValue, ultrafineDustHourlyValue, error)
  }
  
  func requestDayInfo(from startDate: Date, to endDate: Date, completion: @escaping (DateHourIntakePair?, DateHourIntakePair?, Error?) -> Void) {
    completion(fineDustHourlyValuePerDate, ultrafineDustHourlyValuePerDate, error)
  }
}
