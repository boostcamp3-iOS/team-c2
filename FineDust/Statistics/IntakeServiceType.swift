//
//  IntakeManagerType.swift
//  FineDust
//
//  Created by Presto on 30/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// 미세먼지 섭취량 관련 매니저 프로토콜.
protocol IntakeServiceType {
  
  /// 오늘의 미세먼지 및 초미세먼지 섭취량 fetch.
  func requestTodayIntake(completion: @escaping (Int?, Int?, Error?) -> Void)
  
  /// 지정 `Date`로부터 일주일 간의 미세먼지 섭취량 fetch.
  func requestIntakesInWeek(since date: Date,
                            completion: @escaping ([Int]?, [Int]?, Error?) -> Void)
  
  /// 시간당 미세먼지 흡입량 계산.
  ///
  /// `거리 * 농도 * 0.036`
  func intakePerHour(dust: Int, distance: Int) -> Int
}

// MARK: - IntakeServiceType 프로토콜 초기 구현

extension IntakeServiceType {
  func intakePerHour(dust: Int, distance: Int) -> Int {
    return Int(Double(dust * distance) * 0.036)
  }
}
