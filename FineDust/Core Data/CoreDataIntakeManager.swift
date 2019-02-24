//
//  CoreDataIntakeManager.swift
//  FineDust
//
//  Created by Presto on 11/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// 코어데이터의 `Intake` 모델 관련 매니저.
final class CoreDataIntakeManager: CoreDataIntakeManagerType {
  
  /// 코어데이터 매니저.
  let manager: CoreDataManagerType
  
  // MARK: Dependency Injection
  
  init(coreDataManager: CoreDataManagerType = CoreDataManager.shared) {
    manager = coreDataManager
  }
  
  func request(completion: @escaping ([Intake]?, Error?) -> Void) {
    DispatchQueue.main.async {
      do {
        let results = try self.manager.context.fetch(Intake.fetchRequest()) as? [Intake]
        completion(results, nil)
      } catch {
        completion(nil, error)
      }
    } 
  }
  
  /// CREATE
  func save(_ dictionary: [String: Any], completion: @escaping (Error?) -> Void) {
    DispatchQueue.main.async {
      do {
        let intake = Intake(context: self.manager.context)
        dictionary.forEach { intake.setValue($0.value, forKey: $0.key) }
        try self.manager.context.save()
        completion(nil)
      } catch {
        completion(error)
      }
    }
  }
}
