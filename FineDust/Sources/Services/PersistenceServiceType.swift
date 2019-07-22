//
//  PersistenceServiceType.swift
//  FineDust
//
//  Created by Presto on 22/07/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

protocol PersistenceServiceType: class {
  
  func fetchLastAccessedDate() -> Date?
  
  func saveLastAccessedDate(_ date: Date)
  
  func fetchIntakes(from startDate: Date, to endDate: Date) -> DateIntakeValuePair
  
  func saveIntake(_ intake: IntakeValue, at date: Date)
  
  func saveIntakes(_ intakes: [IntakeValue], at dates: [Date])
  
  func fetchLastSavedData() -> LastSavedData?
  
  func saveLastSteps(_ steps: Int)
  
  func saveLastDistance(_ distance: Double)
  
  func saveLastDustData(address: String, grade: Int, recentFineDust: Int)
  
  func saveLastTodayIntake(_ intake: IntakeValue)
  
  func saveLastWeekIntake(_ intakes: [IntakeValue])
}
