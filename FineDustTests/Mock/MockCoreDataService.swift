//
//  MockCoreDataService.swift
//  FineDustTests
//
//  Created by Presto on 04/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import Foundation

class MockCoreDataService: CoreDataServiceType {
  
  var referenceDate: Date = Date()
  
  var error: Error?
  
  var intakesInWeek: [Int]?
  
  func fetchIntakesInWeek(since date: Date, completion: @escaping ([Int]?, Error?) -> Void) {
    completion(intakesInWeek, error)
  }
}
