//
//  Date+.swift
//  FineDust
//
//  Created by Presto on 21/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

extension Date {
  /// 기준 날짜 이전의 날짜 구하기.
  static func before(days: Int, since date: Date = Date()) -> Date {
    return Calendar.current.date(byAdding: .day, value: -days, to: date) ?? Date()
  }
  /// 기준 날짜 이후의 날짜 구하기.
  static func after(days: Int, since date: Date = Date()) -> Date {
    return Calendar.current.date(byAdding: .day, value: days, to: date) ?? Date()
  }
  /// 이전 날짜 구하기.
  func before(days: Int) -> Date {
    return Calendar.current.date(byAdding: .day, value: -days, to: self) ?? Date()
  }
  /// 이후 날짜 구하기.
  func after(days: Int) -> Date {
    return Calendar.current.date(byAdding: .day, value: days, to: self) ?? Date()
  }
  /// 주어진 날짜가 오늘인지 구하기.
  var isToday: Bool {
    return Calendar.current.isDateInToday(self)
  }
}
