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
  
  var error: Error?
  
  var currentDustInfo: RecentDustInfo?
  
  var fineDustIntakeByHour: HourIntakePair?
  
  var ultrafineDustIntakeByHour: HourIntakePair?
  
  func fetchRecentTimeInfo(_ completion: @escaping (RecentDustInfo?, Error?) -> Void) {
    completion(currentDustInfo, error)
  }
  
  func fetchTodayInfo(_ completion: @escaping (HourIntakePair?, HourIntakePair?, Error?) -> Void) {
    completion(fineDustIntakeByHour, ultrafineDustIntakeByHour, error)
  }
}
