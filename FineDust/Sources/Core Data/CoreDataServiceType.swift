//
//  CoreDataServiceType.swift
//  FineDust
//
//  Created by Presto on 03/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// Core Data Service 프로토콜.
protocol CoreDataServiceType: class {
  
  /// 최근 접속 날짜 가져오기.
  func requestLastAccessedDate(completion: @escaping (Date?, Error?) -> Void)
  
  /// 최근 접속 날짜 저장.
  func saveLastAccessedDate(completion: @escaping (Error?) -> Void)
  
  /// 일주일 미세먼지 흡입량 가져오기.
  func requestIntakes(from startDate: Date,
                      to endDate: Date,
                      completion: @escaping (DateIntakeValuePair?, Error?) -> Void)
  
  /// 특정 날짜에 대한 미세먼지 흡입량 저장.
  func saveIntake(_ fineDust: Int,
                  _ ultrafineDust: Int,
                  at date: Date,
                  completion: @escaping (Error?) -> Void)
  
  /// 여러 날짜에 대한 미세먼지 흡입량 저장.
  ///
  /// 모든 인자의 길이가 같아야 한다.
  func saveIntakes(_ fineDusts: [Int],
                   _ ultrafineDusts: [Int],
                   at dates: [Date],
                   completion: @escaping (Error?) -> Void)
  
  /// 마지막으로 요청한 데이터 가져오기.
  func requestLastSavedData(completion: @escaping (LastSavedData?, Error?) -> Void)
  
  /// 마지막으로 요청한 걸음수 저장하기.
  func saveLastSteps(_ steps: Int, completion: @escaping (Error?) -> Void)
  
  /// 마지막으로 요청한 걸음거리 저장하기.
  func saveLastDistance(_ distance: Double, completion: @escaping (Error?) -> Void)
  
  /// 마지막으로 요청한 최근 미세먼지 데이터 저장하기.
  func saveLastDustData(_ address: String,
                        _ grade: Int,
                        _ recentFineDust: Int,
                        completion: @escaping (Error?) -> Void)
  
  /// 마지막으로 요청한 오늘의 흡입 먼지 농도 저장하기.
  func saveLastTodayIntake(_ todayFineDust: Int,
                           _ todayUltrafineDust: Int,
                           completion: @escaping (Error?) -> Void)
  
  /// 마지막으로 요청한 일주일의 흡입 먼지 농도 저장하기.
  func saveLastWeekIntake(_ fineDusts: [Int],
                          _ ultrafineDusts: [Int],
                          completion: @escaping (Error?) -> Void)
}
