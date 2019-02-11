//
//  HealthKitService.swift
//  FineDust
//
//  Created by 이재은 on 01/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// HealthKit 서비스를 구현하는 클래스
final class HealthKitService: HealthKitServiceType {
  
  let healthKitManager: HealthKitManagerType? 
  
  init(healthKit: HealthKitManagerType) {
    self.healthKitManager = healthKit
  }
  
  /// 오늘 걸음 수 가져오는 함수
  func fetchTodayStepCount(completion: @escaping (Double?, Error?) -> Void) {
    
    healthKitManager?.findHealthKitValue(startDate: Date.start(),
                                         endDate: Date(),
                                         hourInterval: 24,
                                         quantityFor: .count(),
                                         quantityTypeIdentifier: .stepCount
    ) { value, _, error in
      if let error = error {
        completion(0, error)
        return
      }
      if let value = value {
        completion(value, nil)
      }
    }
  }
  
  /// 오늘 걸은 거리 가져오는 함수
  func fetchTodayDistance(completion: @escaping (Double?, Error?) -> Void) {
    healthKitManager?.findHealthKitValue(startDate: Date.start(),
                                         endDate: Date(),
                                         hourInterval: 24,
                                         quantityFor: .meter(),
                                         quantityTypeIdentifier: .distanceWalkingRunning
    ) { value, _, error in
      if let error = error {
        completion(0, error)
        return
      }
      if let value = value {
        completion(value, nil)
      }
    }
  }
  
  func requestTodayDistancePerHour(completion: @escaping (HourIntakePair?) -> Void) {
    var hourIntakePair = HourIntakePair()
    
    //비동기 함수를 동기 함수로 구현하기 위한 프로퍼티.
    let group = DispatchGroup()
    
    healthKitManager?.findHealthKitValue(startDate: Date.start(),
                                         endDate: Date.end(),
                                         hourInterval: 1,
                                         quantityFor: .meter(),
                                         quantityTypeIdentifier: .distanceWalkingRunning
    ) { value, hour, error in
      if let error = error {
        print(error.localizedDescription)
        return
      }
      
      group.enter()
      if let hour = hour {
        hourIntakePair[Hour(rawValue: hour) ?? .default] = Int(value ?? 0)
      }
      group.leave()
    }
    
    // 비동기 함수들이 끝날때까지 기다림.
    group.notify(queue: .main) {
      completion(hourIntakePair)
    }
  }
  
  /// 날짜 범위가 주어질 때 그 사이에 시간당 걸음거리를 fetch.
  func fetchDistancePerHour(from startDate: Date,
                            to endDate: Date,
                            completion: @escaping (HourIntakePair?) -> Void) {
    var hourIntakePair = HourIntakePair()
    
    //비동기 함수를 동기 함수로 구현하기 위한 프로퍼티.
    let group = DispatchGroup()
    
    healthKitManager?.findHealthKitValue(startDate: startDate,
                                         endDate: endDate,
                                         hourInterval: 1,
                                         quantityFor: .meter(),
                                         quantityTypeIdentifier: .distanceWalkingRunning
    ) { value, hour, error in
      if let error = error {
        print(error.localizedDescription)
        return
      }
      group.enter()
      if let hour = hour {
        hourIntakePair[Hour(rawValue: hour) ?? .default] = Int(value ?? 0)
      }
      group.leave()
    }
    
    // 비동기 함수들이 끝날때까지 기다림.
    group.notify(queue: .main) {
      completion(hourIntakePair)
    }
  }
}
