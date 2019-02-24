//
//  CoreDataUserManager.swift
//  FineDust
//
//  Created by Presto on 11/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// 코어데이터의 `User` 모델 관련 매니저 프로토콜.
final class CoreDataUserManager: CoreDataUserManagerType {

  /// 코어데이터 매니저.
  let manager: CoreDataManagerType
  
  // MARK: Dependency Injection
  
  init(coreDataManager: CoreDataManagerType = CoreDataManager.shared) {
    manager = coreDataManager
  }
  
  func request(completion: @escaping (User?, Error?) -> Void) {
    DispatchQueue.main.async {
      do {
        let results = try self.manager.context.fetch(User.fetchRequest()) as? [User]
        completion(results?.last, nil)
      } catch {
        completion(nil, error)
      }
    }
  }
  
  func save(_ dictionary: [String: Any], completion: @escaping (Error?) -> Void) {
    DispatchQueue.main.async {
      do {
        let fetchedUsers
          = try self.manager.context.fetch(User.fetchRequest()) as? [User]
        let isNoUser = fetchedUsers?.isEmpty
        let user = isNoUser ?? false ? User(context: self.manager.context) : fetchedUsers?.last
        if let user = user {
          dictionary.forEach { user.setValue($0.value, forKey: $0.key) }
          try self.manager.context.save()
          completion(nil)
        }
      } catch {
        completion(error)
      }
    }
  }
}
