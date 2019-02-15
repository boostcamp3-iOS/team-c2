//
//  CoreDataUserManager.swift
//  FineDust
//
//  Created by Presto on 11/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

final class CoreDataUserManager: CoreDataUserManagerType {
  
  static let shared = CoreDataUserManager()
  
  private init() { }
  
  func request(completion: @escaping (User?, Error?) -> Void) {
    DispatchQueue.main.async {
      do {
        let results = try self.context.fetch(User.fetchRequest()) as? [User]
        completion(results?.last, nil)
      } catch {
        completion(nil, error)
      }
    }
  }
  
  func save(_ dictionary: [String: Any], completion: @escaping (Error?) -> Void) {
    DispatchQueue.main.async {
      do {
        let user = User(context: self.context)
        dictionary.forEach { user.setValue($0.value, forKey: $0.key) }
        try self.context.save()
        completion(nil)
      } catch {
        completion(error)
      }
    }
  }
}
