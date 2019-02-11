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
  
  init(healthKitService: HealthKitServiceType = HealthKitService(healthKit: HealthKitManager()),
       dustInfoService: DustInfoServiceType = DustInfoService(),
       coreDataService: CoreDataServiceType = CoreDataService.shared) {
    self.healthKitService = healthKitService
    self.dustInfoService = dustInfoService
    self.coreDataService = coreDataService
  }
  
  func requestTodayIntake(completion: @escaping (Int?, Int?, Error?) -> Void) {
    dustInfoService.requestDayInfo { fineDust, ultrafineDust, error in
      if let error = error {
        completion(nil, nil, error)
        return
      }
      let totalFineDustValue = fineDust?.reduce(0, { $0 + $1.value })
      let totalUltrafineDustValue = ultrafineDust?.reduce(0, { $0 + $1.value })
      completion(totalFineDustValue, totalUltrafineDustValue, nil)
    }
  }
  
  func requestIntakesInWeek(since date: Date,
                            completion: @escaping ([Int]?, [Int]?, Error?) -> Void) {
    // 특정 날짜에 대한 값은 `fetchTodayIntake`로 가져오고
    // 나머지는 코어데이터에서 가져올 예정
    dustInfoService
      .requestDayInfo(from: date,
                      to: Date.before(days: 1)) { fineDustPerDate, ultrafineDustPerDate, error in
                        if let error = error {
                          completion(nil, nil, error)
                          return
                        }
                        var fineDusts: [Int] = []
                        var ultrafineDusts: [Int] = []
                        fineDustPerDate?
                          .sorted { $0.key < $1.key }
                          .forEach { dictionary in
                            fineDusts.append(dictionary.value.reduce(0, { $0 + $1.value }))
                        }
                        ultrafineDustPerDate?
                          .sorted { $0.key < $1.key }
                          .forEach { dictionary in
                            ultrafineDusts.append(dictionary.value.reduce(0, { $0 + $1.value }))
                        }
                        completion(fineDusts, ultrafineDusts, nil)
    }
  }
}
