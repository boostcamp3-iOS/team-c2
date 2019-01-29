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

protocol CoreDataServiceType {
  associatedtype Entity
  func fetch(forType type: Entity.Type, completion: (Entity?, Error?) -> Void)
  func save(_ dictionary: [String: Any], forType type: Entity.Type, completion: (Error?) -> Void)
}

/// Core Data Service
final class CoreDataService: CoreDataServiceType {
  
  typealias Entity = NSManagedObject

  // MARK: Singleton Object
  
  /// CoreDataService의 싱글톤 객체.
  static let shared = CoreDataService()
  
  // MARK: Private Initializer
  
  private init() { }
  
  // MARK: Property
  
  /// AppDelegate에 있는 viewContext 가져오기.
  private lazy var context: NSManagedObjectContext = {
    guard let delegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
    return delegate.persistentContainer.viewContext
  }()
  
  // MARK: Method
  
  /// 특정 타입의 데이터를 가져오기.
  func fetch<T: NSManagedObject>(forType type: T.Type, completion: (T?, Error?) -> Void) {
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: T.classNameToString)
    do {
      let results = try context.fetch(request) as? [T]
      completion(results?.first, nil)
    } catch {
      completion(nil, error)
    }
  }
  /// 특정 타입에 전달된 데이터를 저장하기.
  func save<T: NSManagedObject>(
    _ dictionary: [String: Any],
    forType type: T.Type,
    completion: (Error?) -> Void
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
