//
//  CoreDataUserManagerType.swift
//  FineDust
//
//  Created by Presto on 03/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import CoreData
import Foundation

/// `User` Entity에 대한 프로토콜.
protocol CoreDataUserManagerType: CoreDataManagerType {

  /// READ
  func request(completion: (User?, Error?) -> Void)
}

// MARK: - CoreDataUserManagerType 프로토콜 초기 구현

extension CoreDataUserManagerType {
  
  func request(completion: (User?, Error?) -> Void) {
    do {
      let results = try context.fetch(User.fetchRequest()) as? [User]
      completion(results?.last, nil)
    } catch {
      completion(nil, error)
    }
  }
  
  func save(_ dictionary: [String: Any], completion: (Error?) -> Void) {
    do {
      let user = User(context: context)
      dictionary.forEach { user.setValue($0.value, forKey: $0.key) }
      try context.save()
      completion(nil)
    } catch {
      completion(error)
    }
  }
}
