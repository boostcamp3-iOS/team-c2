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
       coreDataService: CoreDataServiceType = CoreDataService()) {
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
  
  func requestIntakesInWeek(completion: @escaping ([Int]?, [Int]?, Error?) -> Void) {
    // 초미세먼지 말고 미세먼지에 대해서만 일단 산출. 초미세먼지 부분은 nil을 넘겨줌
    let startDate = Date.before(days: 6)
    let endDate = Date.before(days: 1)
    // 먼저 코어데이터 데이터를 가져옴
    coreDataService
      .requestIntakes(from: startDate, to: endDate) { [weak self] coreDataIntakePerDate, error in
        if let error = error {
          completion(nil, nil, error)
          return
        }
        guard let self = self else { return }
        var fineDustResult: [Date: Int] = [:]
        var ultrafineDustResult: [Date: Int] = [:]
        guard let coreDataIntakePerDate = coreDataIntakePerDate else { return }
        for date in Date.between(startDate, endDate) {
          // 주어진 날짜에 대하여 코어데이터에 데이터가 있는지 확인
          guard let intake = coreDataIntakePerDate[date] else {
            // 데이터가 없으면 DustInfoService 호출
            // 하루하루 값 산출하여 컴플리션 핸들러 호출
            self.dustInfoService
              .requestDayInfo(
                from: date,
                to: endDate
              ) { [weak self] hourlyFineDustIntakePerDate, hourlyUltrafineDustIntakePerDate, error in
                if let error = error {
                  completion(nil, nil, error)
                  return
                }
                guard let self = self else { return }
                guard let hourlyFineDustIntakePerDate = hourlyFineDustIntakePerDate
                else { return }
                guard let hourlyUltrafineDustIntakePerDate = hourlyUltrafineDustIntakePerDate
                else { return }
                self.healthKitService
                  .requestDistancePerHour(
                    from: date,
                    to: endDate
                  ) { [weak self] hourlyDistancePerDate in
                    guard let self = self else { return }
                    guard let hourlyDistancePerDate = hourlyDistancePerDate else { return }
                    let sortedHourlyDistancePerDate = hourlyDistancePerDate.sortedByDate()
                    let sortedHourlyFineDustIntakePerDate
                      = hourlyFineDustIntakePerDate.sortedByDate()
                    let sortedHourlyUltrafineDustPerDate
                      = hourlyUltrafineDustIntakePerDate.sortedByDate()
                    var results = coreDataIntakePerDate.sortedByDate().compactMap { $0.value }
                    zip(sortedHourlyFineDustIntakePerDate, sortedHourlyDistancePerDate)
                      .forEach { argument in
                        let (hourlyFineDustIntakePerDate, hourlyDistancePerDate) = argument
                        let sortedHourlyFineDustIntake = hourlyFineDustIntakePerDate.value.sortedByHour()
                        let sortedHourlyDistance = hourlyDistancePerDate.value.sortedByHour()
                        let intake
                          = zip(sortedHourlyFineDustIntake, sortedHourlyDistance)
                            .reduce(0, {
                              $0 + self.intakePerHour(dust: $1.0.value, distance: $1.1.value)
                            })
                        results.append(intake)
                    }
                    print(1312412, results.count)
                    // 코어데이터 갱신
                    for (index, date) in Date.between(startDate, endDate).enumerated() {
                      self.coreDataService.saveIntake(results[index], at: date) { error in
                        if let error = error {
                          print(error.localizedDescription)
                        }
                      }
                    }
                    completion(results, nil, nil)
                }
            }
            return
          }
          // 데이터가 있으면 빈 딕셔너리에 값 담는 로직 수행
          fineDustResult[date] = intake ?? 0
        }
        // 코어데이터에 주어진 날짜에 대한 데이터가 모두 있을 때 호출됨
        let results = fineDustResult.sortedByDate().map { $0.value }
        completion(results, nil, nil)
    }
  }
}
