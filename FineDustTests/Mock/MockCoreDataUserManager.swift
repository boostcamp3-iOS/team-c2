//
//  MockCoreDataUserManager.swift
//  FineDustTests
//
//  Created by Presto on 12/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import Foundation

class MockCoreDataUserManager: CoreDataUserManagerType {
  
  var user: User?
  
  var dictionary: [String: Any] = [:]
  
  var error: Error?
  
  func request(completion: (User?, Error?) -> Void) {
    completion(user, error)
  }
  
  func save(_ dictionary: [String : Any], completion: (Error?) -> Void) {
    completion(error)
  }
}
