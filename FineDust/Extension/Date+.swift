//
//  Date+.swift
//  FineDust
//
//  Created by Presto on 21/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

extension Date {
  static func day(beforeDays days: Int) -> Date {
    return Calendar.current.date(byAdding: .day, value: -days, to: Date()) ?? Date()
  }
  
  static func day(afterDays days: Int) -> Date {
    return Calendar.current.date(byAdding: .day, value: days, to: Date()) ?? Date()
  }
  
  static func start(of date: Date) -> Date {
    return Calendar.current.startOfDay(for: date)
  }
  
  static func end(of date: Date) -> Date {
    let components = DateComponents(day: 1, second: -1)
    return Calendar.current.date(byAdding: components, to: date) ?? Date()
  }
}
