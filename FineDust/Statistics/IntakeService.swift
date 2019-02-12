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
    // 초미세먼지 말고 미세먼지에 대해서만 일단 산출. 초미세먼지 부분은 nil을 넘겨줌
    dustInfoService
      .requestDayInfo(
        from: date,
        to: Date.before(days: 1)
      ) { [weak self] fineDustPerDate, ultrafineDustPerDate, error in
        var fineDustResult: [Date: Int] = [:]
        var ultrafineDustResult: [Date: Int] = [:]
        if let error = error {
          completion(nil, nil, error)
          return
        }
        guard let self = self else { return }
        let startDate = Date.before(days: 6)
        let endDate = Date.before(days: 1)
        // 6일 전부터 1일 전까지의 코어데이터 가져오기
        // 값이 없는 날이 나오면 반복문을 빠져나가고 DustInfoService 사용
        self.coreDataService
          .requestIntakes(from: startDate, to: endDate) { [weak self] coreDataIntakeByDate, error in
            if let error = error {
              completion(nil, nil, error)
              return
            }
            guard let self = self else { return }
            guard let coreDateIntakeByDate = coreDataIntakeByDate else { return }
            for date in Date.between(startDate, endDate) {
              guard let intake = coreDateIntakeByDate[date] else {
                // 값이 없는 날이므로 DustInfoService 사용
                // 코어데이터에 값이 없는 날짜부터 1일 전까지로 호출
                self.dustInfoService
                  .requestDayInfo(
                    from: date,
                    to: .before(days: 1)
                  ) { [weak self] fineDustIntakePerHourPerDate, ultrafineDustIntakePerHourPerDate, error in
                    if let error = error {
                      completion(nil, nil, error)
                      return
                    }
                    guard let self = self else { return }
                    guard let fineDustIntakePerHourPerDate = fineDustIntakePerHourPerDate else { return }
                    guard let ultrafineDustHourIntakePair = ultrafineDustIntakePerHourPerDate else { return }
                    // 헬스킷서비스 사용하여 걸음수 가져옴
                    self.healthKitService
                      .requestDistancePerHour(from: date, to: .before(days: 1)) { [weak self] distancePerHourPerDate in
                        guard let self = self else { return }
                        guard let distancePerHourPerDate = distancePerHourPerDate else { return }
                        let sortedDistancePerDate = distancePerHourPerDate.sortedByDate()
                        let sortedFineDustValuePerDate = fineDustIntakePerHourPerDate.sortedByDate()
                        var results = coreDateIntakeByDate.sortedByDate().compactMap { $0.value }
                        zip(sortedFineDustValuePerDate, sortedDistancePerDate).forEach { argument in
                          let (fineDustHourIntakePerDate, distanceHourPerDate) = argument
                          let intake = zip(fineDustHourIntakePerDate.value, distanceHourPerDate.value)
                            .reduce(0, { $0 + self.intakePerHour(dust: $1.0.value, distance: $1.1.value) })
                          results.append(intake)
                        }
                        // 코어데이터 갱신 로직 필요
                        completion(results, nil, nil)
                        return
                    }
                }
                return
              }
              fineDustResult[date] = intake ?? 0
            }
            let results = fineDustResult.sortedByDate().map { $0.value }
            completion(results, nil, nil)
        }
    }
  }
}
