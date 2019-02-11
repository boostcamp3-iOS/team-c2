//
//  IntakesGenerator.swift
//  FineDust
//
//  Created by Presto on 28/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// 미세먼지 섭취량 관련 매니저.
final class IntakeService: IntakeServiceType {
  
  // MARK: Property
  
  let healthKitService: HealthKitServiceType
  
  let dustInfoService: DustInfoServiceType
  
  let coreDataService: CoreDataServiceType
  
  // MARK: Dependency Injection
  
  init(healthKitService: HealthKitServiceType,
       dustInfoService: DustInfoServiceType,
       coreDataService: CoreDataServiceType) {
    self.healthKitService = healthKitService
    self.dustInfoService = dustInfoService
    self.coreDataService = coreDataService
  }
  
  func requestTodayIntake(completion: @escaping (Int?, Int?, Error?) -> Void) {
    
  }
  
  func requestIntakesInWeek(since date: Date,
                          completion: @escaping ([Int]?, [Int]?, Error?) -> Void) {
    // 특정 날짜에 대한 값은 `fetchTodayIntake`로 가져오고
    // 나머지는 코어데이터에서 가져옴
  }
}
