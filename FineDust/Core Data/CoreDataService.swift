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

  /// `User` Entity가 들어올, CoreDataManagerType을 준수하는 프로퍼티.
  let userManager: CoreDataUserManagerType
  
  /// `Intake` Entity가 들어올, CoreDataManagerType을 준수하는 프로퍼티.
  let intakeManager: CoreDataIntakeManagerType
  
  init(userManager: CoreDataUserManagerType = CoreDataUserManager.shared,
       intakeManager: CoreDataIntakeManagerType = CoreDataIntakeManager.shared) {
    self.userManager = userManager
    self.intakeManager = intakeManager
  }
  
  func requestLastAccessedDate(completion: @escaping (Date?, Error?) -> Void) {
    userManager.request { user, error in
      // 최신 접속 날짜가 코어데이터에 저장되어 있으면 그 값을 내려줌
      // 그렇지 않으면 최신 접속 날짜를 갱신한 후 그 값을 내려줌
      if let lastAccessedDate = user?.lastAccessedDate {
        completion(lastAccessedDate, error)
      } else {
        saveLastAccessedDate { error in
          completion(Date(), error)
        }
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
      let intakesInDates = intakes.filter { (startDate...endDate).contains($0.date ?? Date()) }
      // 인자에 들어온 날짜를 순회하면서
      // 코어데이터에 해당 날짜에 대한 정보가 저장되어 있으면 그 정보를 내려주고
      // 그렇지 않으면 nil을 내려주어 해당 부분은 통신으로 처리하게 함
      Date.between(startDate, endDate).forEach { currentDate in
        let intakeInCurrentDate = intakesInDates.filter { $0.date?.start == currentDate }.first
        if let currentIntake = intakeInCurrentDate {
          result[currentDate] = Int(currentIntake.value)
        }
      }
      completion(result, nil)
    }
  }
  
  func saveIntake(_ value: Int, at date: Date, completion: @escaping (Error?) -> Void) {
    intakeManager.save([Intake.date: date, Intake.value: Int16(value)], completion: completion)
  }
}
