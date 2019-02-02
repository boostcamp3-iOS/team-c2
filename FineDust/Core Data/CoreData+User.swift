//
//  User+.swift
//  FineDust
//
//  Created by Presto on 25/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import CoreData
import Foundation

/// `User` Entity Attribute 상수 정리
extension User {
  
  /// 설치 날짜 Attribute
  static let installedDate = "installedDate"
}

// MARK - CoreDataUserManager 프로토콜 구현

extension User: CoreDataUserManagerType {
  
  /// 프로토콜 연관 타입을 `User` 엔티티 타입으로 사용
  typealias Entity = User
  
  /// READ
  func fetch(completion: (Entity?, Error?) -> Void) {
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: Entity.classNameToString)
    do {
      let results = try context.fetch(request) as? [Entity]
      completion(results?.first, nil)
    } catch {
      completion(nil, error)
    }
  }
  
  /// CREATE
  func save(_ dictionary: [String: Any], completion: (Error?) -> Void) {
    guard let entity = NSEntityDescription.entity(forEntityName: Entity.classNameToString,
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
