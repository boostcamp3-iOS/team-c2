//
//  Intake+.swift
//  FineDust
//
//  Created by Presto on 25/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import CoreData
import Foundation

/// `Intake` Entity Attribute 상수 정리
extension Intake {
  
  /// 날짜 Attribute
  static let date = "date"
  /// 흡입량 Attribute
  static let value = "value"
}

extension Intake: CoreDataIntakeManagerType {
  
  typealias Entity = Intake
  
  func fetch(completion: (Entity?, Error?) -> Void) {
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: Entity.classNameToString)
    do {
      let results = try context.fetch(request) as? [Entity]
      completion(results?.first, nil)
    } catch {
      completion(nil, error)
    }
  }
  
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
