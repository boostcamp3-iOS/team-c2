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
  func request(completion: ([Intake]?, Error?) -> Void)
}

// MARK: - CoreDataIntakeManagerType 프로토콜 초기 구현

extension CoreDataIntakeManagerType {
  
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
      let users = try context.fetch(User.fetchRequest()) as? [User]
      let lastUser = users?.last
      let intake = Intake(context: context)
      dictionary.forEach { intake.setValue($0.value, forKey: $0.key) }
      lastUser?.addToIntake(intake)
      completion(nil)
    } catch {
      completion(error)
    }
  }
}
