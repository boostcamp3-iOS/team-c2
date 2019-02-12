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
    // 오늘의 시간대에 따른 걸음거리와
    // 오늘의 시간대에 따른 미세먼지 수치를 받아
    // 어떠한 수식을 수행하여 값을 산출한다
    dustInfoService.requestDayInfo { [weak self] fineDust, ultrafineDust, error in
      if let error = error {
        completion(nil, nil, error)
        return
      }
      guard let self = self else { return }
      self.healthKitService.requestTodayDistancePerHour { [weak self] distancePerHour in
        // 각 인자를 `Hour` 오름차순 정렬하고 value 매핑하여 최종적으로 `[Int]` 반환
        guard let self = self else { return }
        guard let sortedFineDust = fineDust?.sortedByHour()
          .map({ $0.value }) else { return }
        guard let sortedUltrafineDust = ultrafineDust?.sortedByHour()
          .map({ $0.value }) else { return }
        guard let sortedDistance = distancePerHour?.sortedByHour()
          .map({ $0.value }) else { return }
        // 시퀀스를 묶어 특정 수식을 통하여 값을 산출
        let totalFineDustValue = zip(sortedFineDust, sortedDistance)
          .reduce(0, { $0 + self.intakePerHour(dust: $1.0, distance: $1.1) })
        let totalUltrafineDustValue = zip(sortedUltrafineDust, sortedDistance)
          .reduce(0, { $0 + self.intakePerHour(dust: $1.0, distance: $1.1) })
        completion(totalFineDustValue, totalUltrafineDustValue, nil)
      }
    }
  }
  
  func requestIntakesInWeek(since date: Date,
                            completion: @escaping ([Int]?, [Int]?, Error?) -> Void) {
    dustInfoService
      .requestDayInfo(from: date,
                      to: Date.before(days: 1))
      { [weak self] fineDustPerDate, ultrafineDustPerDate, error in
        if let error = error {
          completion(nil, nil, error)
          return
        }
        guard let self = self else { return }
        
        
        
        
        
        
        
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
