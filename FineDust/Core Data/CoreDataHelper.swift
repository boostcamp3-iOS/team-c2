//
//  CoreDataHelper.swift
//  FineDust
//
//  Created by Presto on 25/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import CoreData
import Foundation
import UIKit


/// Core Data Helper
class CoreDataHelper {
  
  static let shared = CoreDataHelper()
  
  private lazy var context: NSManagedObjectContext = {
    guard let delegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
    return delegate.persistentContainer.viewContext
  }()
  
  func fetch<T: NSManagedObject>(forType type: T.Type, _ completion: (T?, Error?) -> Void) {
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: T.classNameToString)
    do {
      let results = try context.fetch(request) as? [T]
      completion(results?.first, nil)
    } catch {
      completion(nil, error)
    }
  }
  
  func save<T: NSManagedObject>(
    _ dictionary: [String: Any],
    forType type: T.Type,
    _ completion: (Error?) -> Void
  ) {
    guard let entity = NSEntityDescription.entity(forEntityName: T.classNameToString, in: context)
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
