//
//  IntakeData.swift
//  FineDust
//
//  Created by Presto on 23/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

struct IntakeData {
  
  var weekFineDust = [Int](repeating: 1, count: 7)
  
  var weekUltrafineDust = [Int](repeating: 1, count: 7)
  
  var todayFineDust = 1
  
  var todayUltrafineDust = 1
  
  mutating func reset(to intakeData: IntakeData) {
    self = intakeData
  }
}
