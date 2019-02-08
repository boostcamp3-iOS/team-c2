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
    user.save([User.lastAccessedDate: Date.start()], completion: completion)
  }
  
  func fetchLastAccessedDate(completion: @escaping (Date?, Error?) -> Void) {
    user.fetch { user, error in
      if let lastAccessedDate = user?.lastAccessedDate {
        completion(lastAccessedDate, error)
      } else {
        saveLastAccessedDate { error in
          completion(Date.start(), error)
        }
      }
    }
  }
  
  func fetchIntakes(from startDate: Date,
                    to endDate: Date,
                    completion: @escaping ([Int]?, Error?) -> Void) {
    
    intake.fetch { intakes, error in
      if let error = error {
        completion(nil, error)
        return
      }
      guard let intakes = intakes else { return }
      var result = [Int](repeating: 0, count: 6)
      let startDate = startDate.start
      let endDate = endDate.end
      let sorted = intakes
        .filter { (startDate...endDate).contains($0.date ?? Date()) }
        .sorted { $0.date ?? Date() < $1.date ?? Date() }
      for (index, intake) in sorted.enumerated() {
        let currentDate = startDate.after(days: index)
        if currentDate.start == intake.date?.start ?? Date() {
          
        } else {
          
        }
      }
    }
    
    let array = [1, 2, 3, 4, 5, 6, 7]
    completion(array, nil)
  }
}
