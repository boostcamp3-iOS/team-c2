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
  
  var fineDustHourlyIntake: HourIntakePair?
  
  var ultrafineDustHourlyIntake: HourIntakePair?
  
  var fineDustHourlyIntakePerDate: DateHourIntakePair?
  
  var ultrafineDustHourlyIntakePerDate: DateHourIntakePair?
  
  var error: Error?
  
  func requestRecentTimeInfo(_ completion: @escaping (RecentDustInfo?, Error?) -> Void) {
    completion(recentDustInfo, error)
  }
  
  func requestDayInfo(_ completion: @escaping (HourIntakePair?, HourIntakePair?, Error?) -> Void) {
    completion(fineDustHourlyIntake, ultrafineDustHourlyIntake, error)
  }
  
  func requestDayInfo(from startDate: Date, to endDate: Date, completion: @escaping (DateHourIntakePair?, DateHourIntakePair?, Error?) -> Void) {
    completion(fineDustHourlyIntakePerDate, ultrafineDustHourlyIntakePerDate, error)
  }
}
