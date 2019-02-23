//
//  MockIntakeService.swift
//  FineDustTests
//
//  Created by Presto on 22/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import Foundation

class MockIntakeService: IntakeServiceType {
  
  var todayFineDust: Int?
  
  var todayUltrafineDust: Int?
  
  var weekFineDust: [Int]?
  
  var weekUltrafineDust: [Int]?
  
  var todayIntakeError: Error?
  
  var weekIntakeError: Error?
  
  func requestTodayIntake(completion: @escaping (Int?, Int?, Error?) -> Void) {
    completion(todayFineDust, todayUltrafineDust, todayIntakeError)
  }
  
  func requestIntakesInWeek(completion: @escaping ([Int]?, [Int]?, Error?) -> Void) {
    completion(weekFineDust, weekUltrafineDust, weekIntakeError)
  }
}
