//
//  CoreDataService.swift
//  FineDust
//
//  Created by Presto on 03/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// 코어데이터 서비스 클래스.
final class CoreDataService: CoreDataServiceType {
  
  /// 코어데이터 유저 매니저 프로퍼티.
  let userManager: CoreDataUserManagerType
  
  /// 코어데이터 흡입량 매니저 프로퍼티.
  let intakeManager: CoreDataIntakeManagerType
  
  // MARK: Dependency Injection
  
  init(userManager: CoreDataUserManagerType = CoreDataUserManager(),
       intakeManager: CoreDataIntakeManagerType = CoreDataIntakeManager()) {
    self.userManager = userManager
    self.intakeManager = intakeManager
  }
  
  func requestLastAccessedDate(completion: @escaping (Date?, Error?) -> Void) {
    userManager.request { user, error in
      if let error = error {
        completion(nil, error)
        return
      }
      if let lastAccessedDate = user?.lastAccessedDate {
        completion(lastAccessedDate, nil)
      } else {
        completion(nil, CoreDataError.noUser)
      }
    }
  }
  
  func saveLastAccessedDate(completion: @escaping (Error?) -> Void) {
    userManager.save([User.lastAccessedDate: Date()], completion: completion)
  }
  
  func requestIntakes(from startDate: Date,
                      to endDate: Date,
                      completion: @escaping (DateIntakePair?, Error?) -> Void) {
    intakeManager.request { intakes, error in
      if let error = error {
        completion(nil, error)
        return
      }
      guard let intakes = intakes else { return }
      var result: DateIntakePair = [:]
      let startDate = startDate.start
      let endDate = endDate.end
      let dates = Date.between(startDate, endDate)
      let intakesInDates = intakes.filter { (startDate...endDate).contains($0.date ?? Date()) }
      // 인자에 들어온 날짜를 순회하면서
      // 코어데이터에 해당 날짜에 대한 정보가 저장되어 있으면 그 정보를 내려주고
      // 그렇지 않으면 nil을 내려주어 해당 부분은 통신으로 처리하게 함
      dates.forEach { currentDate in
        let intakeInCurrentDate = intakesInDates.filter { $0.date?.start == currentDate }.first
        if let currentIntake = intakeInCurrentDate {
          result[currentDate] = (Int(currentIntake.fineDust), Int(currentIntake.ultrafineDust))
        }
      }
      completion(result, nil)
    }
  }
  
  func saveIntake(_ fineDust: Int,
                  _ ultrafineDust: Int,
                  at date: Date,
                  completion: @escaping (Error?) -> Void) {
    intakeManager.save([Intake.date: date,
                        Intake.fineDust: Int16(fineDust),
                        Intake.ultrafineDust: Int16(ultrafineDust)], completion: completion)
  }
  
  func saveIntakes(_ fineDusts: [Int],
                   _ ultrafineDusts: [Int],
                   at dates: [Date],
                   completion: @escaping (Error?) -> Void) {
    if !(fineDusts.count == ultrafineDusts.count && ultrafineDusts.count == dates.count) {
      completion(NSError(domain: "count not matched", code: 0, userInfo: nil))
      return
    }
    for index in dates.indices {
      let fineDust = fineDusts[index]
      let ultrafineDust = ultrafineDusts[index]
      let date = dates[index]
      intakeManager.save([Intake.date: date,
                          Intake.fineDust: Int16(fineDust),
                          Intake.ultrafineDust: Int16(ultrafineDust)], completion: completion)
    }
  }
  
  func requestLastSavedData(completion: @escaping (LastSavedData?, Error?) -> Void) {
    userManager.request { user, error in
      if let error = error {
        completion(nil, error)
        return
      }
      guard let user = user else {
        completion(nil, CoreDataError.noUser)
        return
      }
      let lastSavedData = LastSavedData(
        todayFineDust: Int(user.todayFineDust),
        todayUltrafineDust: Int(user.todayUltrafineDust),
        distance: user.distance,
        steps: Int(user.steps),
        address: user.address ?? "",
        grade: Int(user.grade),
        recentFineDust: Int(user.recentFineDust)
      )
      completion(lastSavedData, nil)
    }
  }
  
  func saveLastSteps(_ steps: Int, completion: @escaping (Error?) -> Void) {
    userManager.request { user, error in
      if let error = error {
        completion(error)
        return
      }
      guard user != nil else {
        completion(CoreDataError.noUser)
        return
      }
      self.userManager.save([User.steps: Int16(steps)], completion: completion)
    }
  }
  
  func saveLastDistance(_ distance: Double, completion: @escaping (Error?) -> Void) {
    userManager.request { user, error in
      if let error = error {
        completion(error)
        return
      }
      guard user != nil else {
        completion(CoreDataError.noUser)
        return
      }
      self.userManager.save([User.distance: distance], completion: completion)
    }
  }
  
  func saveLastDustData(_ address: String,
                        _ grade: Int,
                        _ recentFineDust: Int,
                        completion: @escaping (Error?) -> Void) {
    userManager.request { user, error in
      if let error = error {
        completion(error)
        return
      }
      guard user != nil else {
        completion(CoreDataError.noUser)
        return
      }
      self.userManager.save([
        User.address: address,
        User.grade: Int16(grade),
        User.recentFineDust: Int16(recentFineDust)
        ], completion: completion)
    }
  }
  
  func saveLastTodayIntake(_ todayFineDust: Int,
                           _ todayUltrafineDust: Int,
                           completion: @escaping (Error?) -> Void) {
    userManager.request { user, error in
      if let error = error {
        completion(error)
        return
      }
      guard user != nil else {
        completion(CoreDataError.noUser)
        return
      }
      self.userManager.save([
        User.todayFineDust: Int16(todayFineDust),
        User.todayUltrafineDust: Int16(todayUltrafineDust)
        ], completion: completion)
    }
  }
}
