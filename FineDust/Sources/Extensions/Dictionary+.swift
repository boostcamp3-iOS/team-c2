//
//  Dictionary+.swift
//  FineDust
//
//  Created by Presto on 21/07/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

extension Dictionary where Key == Hour {
  
  func sort(byAscending ascending: Bool = true) -> [(key: Key, value: Value)] {
    return ascending ? sorted { $0.key < $1.key } : sorted { $0.key > $1.key }
  }
}

extension Dictionary where Key == Hour, Value: BinaryInteger {
 
  mutating func padIfHourIsNotFilled() {
    Hour.allCases.filter { $0 != .default }.forEach { hour in
      if self[hour] == nil {
        self[hour] = 0
      }
    }
  }
}

extension Dictionary where Key == Date {
  
  func sort(byAscending ascending: Bool = true) -> [(key: Key, value: Value)] {
    return ascending ? sorted { $0.key < $1.key } : sorted { $0.key > $1.key }
  }
}

extension Dictionary where Key == Date, Value == HourIntakePair {
  
  mutating func padIntakeOrEmpty(date: Date, hour: Hour, intake: Int) {
    if self[date] == nil {
      self[date] = [:]
    }
    self[date]?[hour] = intake
  }
}
