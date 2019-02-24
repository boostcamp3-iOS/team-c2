//
//  MockHealthKitService.swift
//  FineDustTests
//
//  Created by Presto on 04/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import Foundation

class MockHealthKitService: HealthKitServiceType {
  
  var stepCount: Double?
  
  var distance: Double?
  
  var hourlyDistance: HourIntakePair?
  
  var hourlyDistancePerDate: DateHourIntakePair?
  
  var isAuthorized: Bool = false
  
  var isDetermined: Bool = false
  
  var error: Error?

  func requestTodayStepCount(completion: @escaping (Double?, Error?) -> Void) {
    completion(stepCount, error)
  }
  
  func requestTodayDistance(completion: @escaping (Double?, Error?) -> Void) {
    completion(distance, error)
  }
  
  func requestTodayDistancePerHour(completion: @escaping (HourIntakePair?) -> Void) {
    completion(hourlyDistance)
  }
  
  func requestDistancePerHour(from startDate: Date, to endDate: Date, completion: @escaping (DateHourIntakePair?) -> Void) {
    completion(hourlyDistancePerDate)
  }
}
