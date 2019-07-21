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
  
  var coreDataIntakePerDate: DateIntakeValuePair?
  
  var lastSavedData: LastSavedData?
  
  var error: Error?
  
  func requestLastAccessedDate(completion: @escaping (Date?, Error?) -> Void) {
    completion(lastAccessedDate, error)
  }
  
  func saveLastAccessedDate(completion: @escaping (Error?) -> Void) {
    completion(error)
  }
  
  func requestIntakes(from startDate: Date, to endDate: Date, completion: @escaping (DateIntakeValuePair?, Error?) -> Void) {
    completion(coreDataIntakePerDate, error)
  }
  
  func saveIntake(_ fineDust: Int, _ ultrafineDust: Int, at date: Date, completion: @escaping (Error?) -> Void) {
    completion(error)
  }
  
  func saveIntakes(_ fineDusts: [Int], _ ultrafineDusts: [Int], at dates: [Date], completion: @escaping (Error?) -> Void) {
    completion(error)
  }

  func requestLastSavedData(completion: @escaping (LastSavedData?, Error?) -> Void) {
    completion(lastSavedData, error)
  }
 
  func saveLastSteps(_ steps: Int, completion: @escaping (Error?) -> Void) {
    completion(error)
  }
  
  func saveLastDistance(_ distance: Double, completion: @escaping (Error?) -> Void) {
    completion(error)
  }
  
  func saveLastDustData(_ address: String, _ grade: Int, _ recentFineDust: Int, completion: @escaping (Error?) -> Void) {
    completion(error)
  }
  
  func saveLastTodayIntake(_ todayFineDust: Int, _ todayUltrafineDust: Int, completion: @escaping (Error?) -> Void) {
    completion(error)
  }
  
  func saveLastWeekIntake(_ fineDusts: [Int], _ ultrafineDusts: [Int], completion: @escaping (Error?) -> Void) {
    completion(error)
  }
}
