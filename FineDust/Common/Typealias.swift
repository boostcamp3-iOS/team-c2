//
//  Typealias.swift
//  FineDust
//
//  Created by Presto on 04/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// 시간대별 흡입량 타입 별칭.
typealias HourIntakePair = [Hour: Int]

/// 날짜별 | 시간대별 흡입량 타입 별칭.
typealias DateHourIntakePair = [Date: HourIntakePair]

/// 날짜별 흡입량 타입 별칭.
typealias DateIntakePair = [Date: (fineDust: Int?, ultrafineDust: Int?)]

// MARK: - 딕셔너리의 Key가 Hour일 때의 확장

extension Dictionary where Key == Hour {
  
  /// `Key`가 `Hour`인 타입에서 `Hour` 순서로 정렬.
  ///
  /// 기본 정렬은 오름차순. 내림차순으로 하려면 인자로 `false`를 주기.
  func sortByHour(isAscending ascending: Bool = true) -> [(key: Key, value: Value)] {
    if ascending {
      return sorted { $0.key < $1.key }
    }
    return sorted { $0.key > $1.key }
  }
}

// MARK: - 딕셔너리의 Key가 Hour이고 Value가 정수일 때 정렬

extension Dictionary where Key == Hour, Value: BinaryInteger {
  
  /// 딕셔너리가 채워지지 않은 경우 0을 첨가함.
  mutating func insertPaddingIfHourIsNotFulled() {
    Hour.allCases.filter { $0 != .default }.forEach { hour in
      if self[hour] == nil {
        self[hour] = 0
      }
    }
  }
}

// MARK: - 딕셔너리의 Key가 Date일 때의 확장

extension Dictionary where Key == Date {
  
  /// Key가 `Date`인 타입에서 `Date` 순서로 정렬.
  ///
  /// 기본 정렬은 오름차순. 내림차순으로 하려면 인자로 `false`를 주기.
  func sortByDate(isAscending ascending: Bool = true) -> [(key: Key, value: Value)] {
    if ascending {
      return sorted { $0.key < $1.key }
    }
    return sorted { $0.key > $1.key }
  }
}

// MARK: 딕셔너리의 Key가 Date이고 Value가 HourIntakePair일 때의 확장

extension Dictionary where Key == Date, Value == HourIntakePair {
  
  /// 특정 키에 대해 빈 딕셔너리를 첨가함.
  mutating func insertIntakeOrEmpty(date: Date, hour: Hour, intake: Int) {
    if self[date] == nil {
      self[date] = [:]
    }
    self[date]?[hour] = intake
  }
}
