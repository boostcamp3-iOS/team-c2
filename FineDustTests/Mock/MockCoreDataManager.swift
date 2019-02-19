//
//  MockCoreDataManager.swift
//  FineDustTests
//
//  Created by Presto on 19/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import CoreData
import Foundation

class MockCoreDataManager: CoreDataManagerType {
  
  var error: Error?
  
  var context: NSManagedObjectContext {
    let container = NSPersistentContainer(name: "Mock")
    container.loadPersistentStores { storeDescription, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
    return container.viewContext
  }
  
  func save(_ dictionary: [String : Any], completion: @escaping (Error?) -> Void) {
    completion(error)
  }
}
