//
//  Date+.swift
//  FineDust
//
//  Created by Presto on 21/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

extension Date {

  /// 기준 날짜 이전의 `Date` 구하기.
  static func before(days: Int, since date: Date = Date()) -> Date {
    return Calendar.current.date(byAdding: .day, value: -days, to: date) ?? Date()
  }
  
  /// 기준 날짜 이후의 `Date` 구하기.
  static func after(days: Int, since date: Date = Date()) -> Date {
    return Calendar.current.date(byAdding: .day, value: days, to: date) ?? Date()
  }
  
  /// 이전 `Date` 구하기.
  func before(days: Int) -> Date {
    return Calendar.current.date(byAdding: .day, value: -days, to: self) ?? Date()
  }
  
  /// 이후 `Date` 구하기.
  func after(days: Int) -> Date {
    return Calendar.current.date(byAdding: .day, value: days, to: self) ?? Date()
  }
  
  /// 기준 날짜의 0시 `Date` 구하기.
  static func start(of date: Date = Date()) -> Date {
    return Calendar.current.startOfDay(for: date)
  }
  
  /// 기준 날짜의 23시 59분 59초 `Date` 구하기.
  static func end(of date: Date = Date()) -> Date {
    let components = DateComponents(day: 1, second: -1)
    return Calendar.current.date(byAdding: components, to: start(of: date)) ?? Date()
  }
  
  /// 0시 `Date` 구하기.
  var start: Date {
    return Calendar.current.startOfDay(for: self)
  }
  
  /// 23시 59분 59초 `Date` 구하기.
  var end: Date {
    let components = DateComponents(day: 1, second: -1)
    return Calendar.current.date(byAdding: components, to: start) ?? Date()
  }
  
  /// 주어진 날짜가 오늘인지 구하기.
  var isToday: Bool {
    return Calendar.current.isDateInToday(self)
  }
  
  /// 주어진 날짜 사이에 있는 `Date` 배열 반환.
  static func between(_ startDate: Date, _ endDate: Date) -> [Date] {
    var result = [Date]()
    var start = startDate.start
    let end = endDate.end
    while start <= end {
      result.append(start)
      start = start.after(days: 1)
    }
    return result
  }
}
