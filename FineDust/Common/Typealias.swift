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
typealias DateIntakePair = [Date: Int?]

// MARK: - 딕셔너리의 Key가 Hour일 때의 확장

extension Dictionary where Key == Hour {
  
  /// HourIntakePair 타입에서 `Hour` 순서로 정렬.
  ///
  /// 기본 정렬은 오름차순. 내림차순으로 하려면 인자로 `false`를 주기.
  func sortedByHour(isAscending ascending: Bool = true) -> [(key: Key, value: Value)] {
    if ascending {
      return sorted { $0.key < $1.key }
    }
    return sorted { $0.key > $1.key }
  }
}

// MARK: - 딕셔너리의 Key가 Date일 때의 확장

extension Dictionary where Key == Date {
  func sortedByDate(isAscending ascending: Bool = true) -> [(key: Key, value: Value)] {
    if ascending {
      return sorted { $0.key < $1.key }
    }
    return sorted { $0.key > $1.key }
  }
}
