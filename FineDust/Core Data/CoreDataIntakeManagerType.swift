//
//  CoreDataIntakeManagerType.swift
//  FineDust
//
//  Created by Presto on 03/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import CoreData
import Foundation

/// `Intake` Entity에 대한 Manager 프로토콜.
protocol CoreDataIntakeManagerType: CoreDataManagerType {
  
  /// READ
  func fetch(completion: ([Intake]?, Error?) -> Void)
}

// MARK: - CoreDataIntakeManagerType 프로토콜 초기 구현

extension CoreDataIntakeManagerType {
  
  func fetch(completion: ([Intake]?, Error?) -> Void) {
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: Intake.classNameToString)
    do {
      let results = try context.fetch(request) as? [Intake]
      completion(results, nil)
    } catch {
      completion(nil, error)
    }
  }
  
  /// CREATE
  func save(_ dictionary: [String: Any], completion: (Error?) -> Void) {
    guard let entity = NSEntityDescription.entity(forEntityName: Intake.classNameToString,
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
