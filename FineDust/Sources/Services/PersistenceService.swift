//
//  PersistenceService.swift
//  FineDust
//
//  Created by Presto on 22/07/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

import RealmSwift

final class PersistenceService: PersistenceServiceType {
  
  private let realm = try! Realm()
  
  func fetchLastAccessedDate() -> Date? {
    guard let result = realm.objects(UserModel.self).last else { return nil }
    return result.lastAccessedDate
  }
  
  func saveLastAccessedDate(_ date: Date) {
    guard let result = realm.objects(UserModel.self).last else { return }
    try! realm.write {
      result.lastAccessedDate = .init()
    }
  }
  
  func fetchIntakes(from startDate: Date, to endDate: Date) -> DateIntakeValuePair {
    let results = realm.objects(IntakeModel.self)
    var dateIntakeValuePair = DateIntakeValuePair()
    let dates = Date.between(startDate.start, endDate.end)
    let intakesInDates = Array(results.filter { (startDate...endDate).contains($0.date) })
    dates.forEach { date in
      let intakeInCurrentDate = intakesInDates.filter { $0.date.start == date }.first
      if let currentIntake = intakeInCurrentDate {
        dateIntakeValuePair[date] = [Int(currentIntake.fineDust), Int(currentIntake.ultraFineDust)]
      }
    }
    return dateIntakeValuePair
  }
  
  func saveIntake(_ intake: IntakeValue, at date: Date) {
    let object = IntakeModel().then {
      $0.fineDust = intake.fineDust
      $0.ultraFineDust = intake.ultraFineDust
      $0.date = date
    }
    try! realm.write {
      realm.add(object)
    }
  }
  
  func saveIntakes(_ intakes: [IntakeValue], at dates: [Date]) {
    zip(intakes, dates).forEach { intakeValue, date in
      let object = IntakeModel().then {
        $0.fineDust = intakeValue.fineDust
        $0.ultraFineDust = intakeValue.ultraFineDust
        $0.date = date
      }
      try! realm.write {
        realm.add(object)
      }
    }
  }
  
  func fetchLastSavedData() -> LastSavedData? {
    guard let result = realm.objects(UserModel.self).last else { return nil }
    let lastSavedData = LastSavedData(
      todayFineDust: Int(result.todayFineDust),
      todayUltraFineDust: Int(result.todayUltraFineDust),
      distance: result.distance,
      steps: result.steps,
      address: result.address,
      grade: result.grade,
      recentFineDust: result.recentFineDust,
      weekFineDust: Array(result.weekFineDust),
      weekUltraFineDust: Array(result.weekUltraFineDust)
    )
    return lastSavedData
  }
  
  func saveLastSteps(_ steps: Int) {
    guard let result = realm.objects(UserModel.self).last else { return }
    try! realm.write {
      result.steps = steps
    }
  }
  
  func saveLastDistance(_ distance: Double) {
    guard let result = realm.objects(UserModel.self).last else { return }
    try! realm.write {
      result.distance = distance
    }
  }
  
  func saveLastDustData(address: String, grade: Int, recentFineDust: Int) {
    guard let result = realm.objects(UserModel.self).last else { return }
    try! realm.write {
      result.address = address
      result.grade = grade
      result.recentFineDust = recentFineDust
    }
  }
  
  func saveLastTodayIntake(_ intake: IntakeValue) {
    guard let result = realm.objects(UserModel.self).last else { return }
    try! realm.write {
      result.todayFineDust = intake.fineDust
      result.todayUltraFineDust = intake.ultraFineDust
    }
  }
  
  func saveLastWeekIntake(_ intakes: [IntakeValue]) {
    guard let result = realm.objects(UserModel.self).last else { return }
    let fineDusts = intakes.map { $0.fineDust }
    let ultraFineDusts = intakes.map { $0.ultraFineDust }
    try! realm.write {
      result.weekFineDust.removeAll()
      result.weekUltraFineDust.removeAll()
      result.weekFineDust.append(objectsIn: fineDusts)
      result.weekUltraFineDust.append(objectsIn: ultraFineDusts)
    }
  }
}
