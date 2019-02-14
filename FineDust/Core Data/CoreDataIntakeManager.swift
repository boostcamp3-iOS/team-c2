//
//  CoreDataIntakeManager.swift
//  FineDust
//
//  Created by Presto on 11/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

final class CoreDataIntakeManager: CoreDataIntakeManagerType {
  
  static let shared = CoreDataIntakeManager()
  
  private init() { }
  
  func request(completion: ([Intake]?, Error?) -> Void) {
    do {
      let results = try context.fetch(Intake.fetchRequest()) as? [Intake]
      completion(results, nil)
    } catch {
      completion(nil, error)
    }
  }
  
  /// CREATE
  func save(_ dictionary: [String: Any], completion: (Error?) -> Void) {
    do {
      let intake = Intake(context: context)
      dictionary.forEach { intake.setValue($0.value, forKey: $0.key) }
      try context.save()
      completion(nil)
    } catch {
      completion(error)
    }
  }
}
