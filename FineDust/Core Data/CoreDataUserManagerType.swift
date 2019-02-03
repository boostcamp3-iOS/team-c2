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
  func fetch(completion: (User?, Error?) -> Void)
}

// MARK: - CoreDataUserManagerType 프로토콜 초기 구현

extension CoreDataUserManagerType {
  
  func fetch(completion: (User?, Error?) -> Void) {
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: User.classNameToString)
    do {
      let results = try context.fetch(request) as? [User]
      completion(results?.first, nil)
    } catch {
      completion(nil, error)
    }
  }
  
  func save(_ dictionary: [String: Any], completion: (Error?) -> Void) {
    guard let entity = NSEntityDescription.entity(forEntityName: User.classNameToString,
                                                  in: context)
      else { return }
    let newInstance = NSManagedObject(entity: entity, insertInto: context)
    dictionary.forEach { newInstance.setValue($0.value, forKey: $0.key) }
    do {
      try context.save()
    } catch {
      completion(error)
    }
  }
  
}
