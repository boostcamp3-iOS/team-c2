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
  
  var date: Date?
  
  var intakes: DateIntakePair?
  
  var error: Error?
  
  func requestLastAccessedDate(completion: @escaping (Date?, Error?) -> Void) {
    completion(date, error)
  }
  
  func saveLastAccessedDate(completion: @escaping (Error?) -> Void) {
    completion(error)
  }
  
  func requestIntakes(from startDate: Date, to endDate: Date, completion: @escaping (DateIntakePair?, Error?) -> Void) {
    completion(intakes, error)
  }
  
  func saveIntake(_ value: Int, at date: Date, completion: @escaping (Error?) -> Void) {
    completion(error)
  }
}
