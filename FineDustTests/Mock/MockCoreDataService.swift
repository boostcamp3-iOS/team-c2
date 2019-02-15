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
  
  var lastAccessedDate: Date?
  
  var coreDataIntakePerDate: DateIntakePair?
  
  var lastSavedData: LastSavedData?
  
  var error: Error?
  
  func requestLastAccessedDate(completion: @escaping (Date?, Error?) -> Void) {
    completion(lastAccessedDate, error)
  }
  
  func saveLastAccessedDate(completion: @escaping (Error?) -> Void) {
    completion(error)
  }
  
  func requestIntakes(from startDate: Date, to endDate: Date, completion: @escaping (DateIntakePair?, Error?) -> Void) {
    completion(coreDataIntakePerDate, error)
  }
  
  func saveIntake(fineDust: Int, ultrafineDust: Int, at date: Date, completion: @escaping (Error?) -> Void) {
    completion(error)
  }
  
  func requestLastSavedData(completion: @escaping (LastSavedData?, Error?) -> Void) {
    completion(lastSavedData, error)
  }
  
  func saveLastSavedData(_ lastSavedData: LastSavedData, completion: @escaping (Error?) -> Void) {
    completion(error)
  }
}
