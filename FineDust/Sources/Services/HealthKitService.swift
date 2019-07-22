//
//  HealthKitService.swift
//  FineDust
//
//  Created by 이재은 on 01/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

final class HealthKitService: HealthKitServiceType {
  
  private let healthKitManager: HealthKitManagerType
  
  init(healthKit: HealthKitManagerType = HealthKitManager()) {
    self.healthKitManager = healthKit
  }
  
  var isAuthorized: Bool {
    return healthKitManager.authorizationStatus == (.sharingAuthorized, .sharingAuthorized)
  }
  
  var isDetermined: Bool {
    return !(healthKitManager.authorizationStatus == (.notDetermined, .notDetermined))
  }
  
  /// 오늘 걸음 수 가져오는 함수
  func requestTodayStepCount(completion: @escaping (Double?, Error?) -> Void) {
    
    healthKitManager.findHealthKitValue(startDate: Date.start(),
                                         endDate: Date(),
                                         hourInterval: 24,
                                         quantityFor: .count(),
                                         identifier: .stepCount
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
  func requestTodayDistance(completion: @escaping (Double?, Error?) -> Void) {
    healthKitManager.findHealthKitValue(startDate: .start(),
                                         endDate: Date(),
                                         hourInterval: 24,
                                         quantityFor: .meter(),
                                         identifier: .distanceWalkingRunning
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
  
  /// 오늘 시간당 걸음거리를 HourIntakePair로 리턴하는 함수.
  func requestTodayDistancePerHour(completion: @escaping (HourIntakePair?) -> Void) {
    var hourIntakePair = HourIntakePair()
    
    //비동기 함수를 동기 함수로 구현하기 위한 세마포어.
    let semaphore = DispatchSemaphore(value: 0)
    var temp = 0
    
    healthKitManager.findHealthKitValue(startDate: .start(),
                                         endDate: .end(),
                                         hourInterval: 1,
                                         quantityFor: .meter(),
                                         identifier: .distanceWalkingRunning
    ) { value, hour, error in
      if let error = error as? ServiceErrorType {
        errorLog("Healthkit Query Error: \(error.localizedDescription)")
        for hour in 0...23 {
          hourIntakePair[Hour(rawValue: hour) ?? .default] = 0
        }
        semaphore.signal()
      } else if let hour = hour {
        var value = Int(value ?? 0)
        // 걸음거리가 500 이하일때는 실내로 취급한다.
        value = value < 500 ? 0 : value
        hourIntakePair[Hour(rawValue: hour) ?? .default] = value
        
        temp += 1
        if temp == 24 {
          semaphore.signal()
        }
      }
    }
    
    semaphore.wait()
    completion(hourIntakePair)
  }
  
  /// 날짜 범위가 주어질 때 해당 날짜에 1시간당 걸음거리를 DateHourIntakePair로 리턴하는 함수.
  func requestDistancePerHour(from startDate: Date,
                              to endDate: Date,
                              completion: @escaping (DateHourIntakePair?) -> Void) {
    var hourIntakePair = HourIntakePair()
    var dateHourIntakePair = DateHourIntakePair()
    // startDate와 endDate 사이에 며칠인지 파악.
    let interval = Calendar.current.dateComponents([.day], from: startDate, to: endDate)
    
    guard let day = interval.day, day >= 0 else {
      errorLog("Date 입력값을 잘못 입력하였습니다.")
      completion(nil)
      return
    }
    
    // 비동기 함수를 동기 함수로 구현하기 위한 세마포어.
    let semaphore = DispatchSemaphore(value: 0)
    
    var temp = 0
    
    for index in 0...day {
      let indexDate = startDate.after(days: index)
      healthKitManager.findHealthKitValue(startDate: indexDate.start,
                                           endDate: indexDate.end,
                                           hourInterval: 1,
                                           quantityFor: .meter(),
                                           identifier: .distanceWalkingRunning
      ) { value, hour, error in
        if let error = error as? ServiceErrorType {
          errorLog("HealthKit Query error: \(error.localizedDescription)")
          for hour in 0...23 {
            hourIntakePair[Hour(rawValue: hour) ?? .default] = 0
            temp += 1
          }
          dateHourIntakePair[indexDate.start] = hourIntakePair
          
          if temp == (day + 1) * 24 {
            semaphore.signal()
          }
        } else if let hour = hour {
          var value = Int(value ?? 0)
          // 걸음거리가 500 이하일때는 실내로 취급한다.
          value = value < 500 ? 0 : value
          hourIntakePair[Hour(rawValue: hour) ?? .default] = value
          dateHourIntakePair[indexDate.start] = hourIntakePair
          
          temp += 1
          if temp == (day + 1) * 24 {
            semaphore.signal()
          }
        }
      }
    }
    
    semaphore.wait()
    completion(dateHourIntakePair)
  }
}
