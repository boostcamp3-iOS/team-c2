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
  
  /// CoreDataService 싱글톤 객체.
  static let shared = CoreDataService()
  
  /// `User` Entity가 들어올, CoreDataManagerType을 준수하는 프로퍼티.
  let user: CoreDataUserManagerType
  
  /// `Intake` Entity가 들어올, CoreDataManagerType을 준수하는 프로퍼티.
  let intake: CoreDataIntakeManagerType
  
  private init() {
    let context = CoreDataManager.shared.context
    user = User(context: context)
    intake = Intake(context: context)
  }
  
  func saveLastAccessedDate(completion: @escaping (Error?) -> Void) {
    user.save([User.lastAccessedDate: Date()], completion: completion)
  }
  
  func requestLastAccessedDate(completion: @escaping (Date?, Error?) -> Void) {
    user.request { user, error in
      // 최신 접속 날짜가 코어데이터에 저장되어 있으면 그 값을 내려줌
      // 그렇지 않으면 최신 접속 날짜를 갱신한 후 그 값을 내려줌
      if let lastAccessedDate = user?.lastAccessedDate {
        completion(lastAccessedDate, error)
      } else {
        saveLastAccessedDate { error in
          completion(Date.start(), error)
        }
      }
    }
  }
  
  func requestIntakes(from startDate: Date,
                      to endDate: Date,
                      completion: @escaping ([Date: Int?]?, Error?) -> Void) {
    intake.request { intakes, error in
      if let error = error {
        completion(nil, error)
        return
      }
      guard let intakes = intakes else { return }
      var result: [Date: Int?] = [:]
      let startDate = startDate.start
      let endDate = endDate.end
      let intakesInDates = intakes.filter { (startDate...endDate).contains($0.date ?? Date()) }
      var currentDate = startDate
      // 인자에 들어온 날짜를 순회하면서
      // 코어데이터에 해당 날짜에 대한 정보가 저장되어 있으면 그 정보를 내려주고
      // 그렇지 않으면 nil을 내려주어 해당 부분은 통신으로 처리하게 함
      while currentDate <= endDate.end {
        let intakeInCurrentDate = intakesInDates.filter { $0.date?.start == currentDate }.first
        if let currentIntake = intakeInCurrentDate {
          result[currentDate] = Int(currentIntake.value)
        } else {
          result[currentDate] = nil
        }
        currentDate = currentDate.after(days: 1).start
      }
      completion(result, nil)
    }
  }
  
  func saveIntake(_ value: Int, at date: Date, completion: @escaping (Error?) -> Void) {
    intake.save([Intake.date: Int16(value)], completion: completion)
  }
}
