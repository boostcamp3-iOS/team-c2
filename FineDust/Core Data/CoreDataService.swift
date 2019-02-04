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
  let user: CoreDataManagerType
  
  /// `Intake` Entity가 들어올, CoreDataManagerType을 준수하는 프로퍼티.
  let intake: CoreDataManagerType
  
  private init() {
    let context = CoreDataManager.shared.context
    user = User(context: context)
    intake = Intake(context: context)
  }
  
  func fetchIntakesInWeek(since date: Date, completion: @escaping ([Int]?, Error?) -> Void) {
    let array = [1, 2, 3, 4, 5, 6, 7]
    completion(array, nil)
  }
}
