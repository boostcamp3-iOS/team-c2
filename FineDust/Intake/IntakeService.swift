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
  
  let todayExtensionManager: TodayExtensionManagerType
  
  // MARK: Dependency Injection
  
  init(healthKitService: HealthKitServiceType = HealthKitService(healthKit: HealthKitManager()),
       dustInfoService: DustInfoServiceType = DustInfoService(),
       coreDataService: CoreDataServiceType = CoreDataService(),
       todayExtensionManager: TodayExtensionManagerType = TodayExtensionManager.shared) {
    self.healthKitService = healthKitService
    self.dustInfoService = dustInfoService
    self.coreDataService = coreDataService
    self.todayExtensionManager = todayExtensionManager
  }
  
  func requestTodayIntake(completion: @escaping (Int?, Int?, Error?) -> Void) {
    // 오늘의 시간대에 따른 걸음거리와
    // 오늘의 시간대에 따른 미세먼지 수치를 받아
    // 어떠한 수식을 수행하여 값을 산출한다
    dustInfoService
      .requestDayInfo { [weak self] hourlyFineDustIntake, hourlyUltrafineDustIntake, error in
        guard let hourlyFineDustIntake = hourlyFineDustIntake,
          let hourlyUltrafineDustIntake = hourlyUltrafineDustIntake
          else {
            completion(nil, nil, error)
            return
        }
        guard let self = self else { return }
        self.healthKitService
          .requestTodayDistancePerHour { [weak self] hourlyDistance in
            guard let self = self, let hourlyDistance = hourlyDistance else { return }
            if !self.healthKitService.isAuthorized {
              completion(nil, nil, HealthKitError.notAuthorized)
              return
            }
            let (fineDust, ultrafineDust)
              = self.totalHourlyIntake(hourlyFineDustIntake,
                                       hourlyUltrafineDustIntake,
                                       hourlyDistance)
            self.todayExtensionManager
              .shareTodayIntakes(fineDust, ultrafineDust)
            print("오늘의 흡입량 가져오기 성공")
            print(fineDust)
            print(ultrafineDust)
            completion(fineDust, ultrafineDust, nil)
        }
    }
  }
  
  func requestIntakesInWeek(completion: @escaping ([Int]?, [Int]?, Error?) -> Void) {
    let startDate = Date.before(days: 6)
    let endDate = Date.before(days: 1)
    coreDataService
      .requestIntakes(from: startDate, to: endDate) { [weak self] coreDataIntakePerDate, error in
        if let error = error {
          completion(nil, nil, error)
          return
        }
        guard let self = self else { return }
        var fineDustIntakePerDate: [Date: Int] = [:]
        var ultrafineDustIntakePerDate: [Date: Int] = [:]
        guard let coreDataIntakePerDate = coreDataIntakePerDate else { return }
        let dates = Date.between(startDate, endDate)
        for date in dates {
          guard let savedIntake = coreDataIntakePerDate[date] else {
            self.dustInfoService
              .requestDayInfo(
                from: date,
                to: endDate
              ) { [weak self] hourlyFineDustIntakePerDate, hourlyUltrafineDustIntakePerDate, error in
                if let error = error {
                  completion(nil, nil, error)
                  return
                }
                guard let self = self,
                  let hourlyFineDustIntakePerDate = hourlyFineDustIntakePerDate,
                  let hourlyUltrafineDustIntakePerDate = hourlyUltrafineDustIntakePerDate
                  else { return }
                self.healthKitService
                  .requestDistancePerHour(
                    from: date,
                    to: endDate) { [weak self] hourlyDistancePerDate in
                      guard let self = self,
                        let hourlyDistancePerDate = hourlyDistancePerDate
                        else { return }
                      if !self.healthKitService.isAuthorized {
                        completion(nil, nil, HealthKitError.notAuthorized)
                        return
                      }
                      let savedIntakes = coreDataIntakePerDate.sortByDate().map { $0.value }
                      let savedFineDustIntakes = savedIntakes.compactMap { $0.0 }
                      let savedUltrafineDustIntakes = savedIntakes.compactMap { $0.1 }
                      let (fineDusts, ultrafineDusts)
                        = self.totalHourlyIntakes(hourlyFineDustIntakePerDate,
                                                  hourlyUltrafineDustIntakePerDate,
                                                  hourlyDistancePerDate)
                      let totalFineDustIntakes = [savedFineDustIntakes, fineDusts].flatMap { $0 }
                      let totalUltrafineDustIntakes
                        = [savedUltrafineDustIntakes, ultrafineDusts].flatMap { $0 }
                      // 코어데이터 갱신
                      self.coreDataService
                        .saveIntakes(totalFineDustIntakes,
                                     totalUltrafineDustIntakes,
                                     at: dates) { error in
                                      if let error = error {
                                        print("코어데이터 갱신 실패: ", error.localizedDescription)
                                        return
                                      } else {
                                        print("코어데이터 갱신 성공")
                                      }
                      }
                      print("일주일치 흡입량 가져오기 성공")
                      print(totalFineDustIntakes)
                      print(totalUltrafineDustIntakes)
                      completion(totalFineDustIntakes, totalUltrafineDustIntakes, nil)
                }
            }
            return
          }
          fineDustIntakePerDate[date] = savedIntake.fineDust ?? 0
          ultrafineDustIntakePerDate[date] = savedIntake.ultrafineDust ?? 0
        }
        print("일주일치 흡입량 가져오기 성공")
        print("코어데이터에 주어진 날짜에 대한 데이터가 모두 있음")
        let totalFineDustIntakes = fineDustIntakePerDate.sortByDate().map { $0.value }
        let totalUltrafineDustIntakes = ultrafineDustIntakePerDate.sortByDate().map { $0.value }
        completion(totalFineDustIntakes, totalUltrafineDustIntakes, nil)
    }
  }
}

private extension IntakeService {
  
  /// 시간당 미세먼지 흡입량 계산.
  ///
  /// `거리 * 농도 * 0.036 * 0.01`
  func intakePerHour(dust: Int, distance: Int) -> Int {
    return Int(Double(dust * distance) * 0.036 * 0.01)
  }
  
  /// 시간별 흡입량 계산.
  func totalHourlyIntake(_ hourlyFineDustIntake: HourIntakePair,
                         _ hourlyUltrafineDustIntake: HourIntakePair,
                         _ hourlyDistance: HourIntakePair) -> (Int, Int) {
    let sortedFineDust = hourlyFineDustIntake.sortByHour().map { $0.value }
    let sortedUltrafineDust = hourlyUltrafineDustIntake.sortByHour().map { $0.value }
    let sortedDistance = hourlyDistance.sortByHour().map { $0.value }
    let fineDust = zip(sortedFineDust, sortedDistance)
      .reduce(0, { $0 + intakePerHour(dust: $1.0, distance: $1.1) })
    let ultrafineDust = zip(sortedUltrafineDust, sortedDistance)
      .reduce(0, { $0 + intakePerHour(dust: $1.0, distance: $1.1) })
    return (fineDust, ultrafineDust)
  }
  
  /// 날짜별 시간별 총 흡입량 계산.
  func totalHourlyIntakes(_ hourlyFineDustIntakePerDate: DateHourIntakePair,
                          _ hourlyUltrafineDustIntakePerDate: DateHourIntakePair,
                          _ hourlyDistancePerDate: DateHourIntakePair) -> ([Int], [Int]) {
    var fineDusts: [Int] = []
    var ultrafineDusts: [Int] = []
    let sortedHourlyFineDustIntakePerDate = hourlyFineDustIntakePerDate.sortByDate()
    let sortedHourlyUltrafineDustIntakePerDate = hourlyUltrafineDustIntakePerDate.sortByDate()
    let sortedHourlyDistancePerDate = hourlyDistancePerDate.sortByDate()
    zip(sortedHourlyFineDustIntakePerDate, sortedHourlyDistancePerDate).forEach {
      let (hourlyFineDustIntakePerDate, hourlyDistancePerDate) = $0
      let sortedHourlyFineDustIntake = hourlyFineDustIntakePerDate.value.sortByHour()
      let sortedHourlyDistance = hourlyDistancePerDate.value.sortByHour()
      let intake = zip(sortedHourlyFineDustIntake, sortedHourlyDistance)
        .reduce(0, { $0 + intakePerHour(dust: $1.0.value, distance: $1.1.value) })
      fineDusts.append(intake)
    }
    zip(sortedHourlyUltrafineDustIntakePerDate, sortedHourlyDistancePerDate).forEach {
      let (hourlyUltrafineDustIntakePerDate, hourlyDistancePerDate) = $0
      let sortedHourlyUltrafineDustIntake = hourlyUltrafineDustIntakePerDate.value.sortByHour()
      let sortedHourlyDistance = hourlyDistancePerDate.value.sortByHour()
      let intake = zip(sortedHourlyUltrafineDustIntake, sortedHourlyDistance)
        .reduce(0, { $0 + intakePerHour(dust: $1.0.value, distance: $1.1.value) })
      ultrafineDusts.append(intake)
    }
    return (fineDusts, ultrafineDusts)
  }
}
