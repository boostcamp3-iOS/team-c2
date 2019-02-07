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
    user.save([User.lastDate: Date()], completion: completion)
  }
  
  func fetchLastAccessedDate(completion: @escaping (Date?, Error?) -> Void) {
    user.fetch { user, error in
      completion(user?.lastDate, error)
    }
  }
    
  
  func fetchIntakesInWeek(since date: Date, completion: @escaping ([Int]?, Error?) -> Void) {
    let array = [1, 2, 3, 4, 5, 6, 7]
    completion(array, nil)
  }
}
