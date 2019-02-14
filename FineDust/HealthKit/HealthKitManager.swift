//
//  HealthKitManager.swift
//  FineDust
//
//  Created by zun on 01/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation
import HealthKit

/// HealthKit 매니저를 구현하는  클래스.
final class HealthKitManager: HealthKitManagerType {
  
  // MARK: - Properties
  
  /// Health 앱 데이터 권한을 요청하기 위한 프로퍼티.
  private let healthStore = HKHealthStore()
  
  /// Health 앱 데이터 중 걸음 수를 가져오기 위한 프로퍼티.
  private let stepCount = HKObjectType.quantityType(forIdentifier: .stepCount)
  
  /// Health 앱 데이터 중 걸은 거리를 가져오기 위한 프로퍼티.
  private let distance = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)
  
  /// Health App 권한을 나타내는 변수.
  private var isAuthorized = true
  
  // MARK: - Method
  
  /// App 시작시 Health App 정보 접근권한을 얻기 위한 메소드.
  func requestAuthorization() {
    guard let stepCount = stepCount, let distance = distance else {
      print("stepCount, distance properties error")
      return
    }
    
    // 권한이 없을 경우 사용자가 직접 허용을 해야하게끔 해주기 위해 변수를 false로 설정.
    if healthStore.authorizationStatus(for: stepCount) == .sharingDenied
      || healthStore.authorizationStatus(for: distance) == .sharingDenied {
      NotificationCenter.default.post(
        name: .healthKitAuthorizationSharingDenied,
        object: nil)
      print("denied")
      return
    }
    
    // 걸음 데이터를 얻기 위해 Set을 만든 다음 권한 요청.
    let healthKitTypes: Set = [stepCount, distance]
    
    // 권한요청.
    healthStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) { _, error in
      if let error = error {
        print("request authorization error : \(error.localizedDescription)")
      } else {
        print("complete request authorization")
        
        if self.healthStore.authorizationStatus(for: stepCount) == .sharingAuthorized,
          self.healthStore.authorizationStatus(for: distance) == .sharingAuthorized {
          NotificationCenter.default.post(
            name: .healthKitAuthorizationSharingAuthorized,
            object: nil)
        }
      }
    }
  }
  
  /// HealthKit App의 저장된 자료를 찾아주는 메소드.
  func findHealthKitValue(startDate: Date,
                          endDate: Date,
                          hourInterval: Int,
                          quantityFor: HKUnit,
                          quantityTypeIdentifier: HKQuantityTypeIdentifier,
                          completion: @escaping (Double?, Int?, Error?) -> Void) {
    if let quantityType = HKQuantityType.quantityType(forIdentifier: quantityTypeIdentifier) {
      
      let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        return formatter
      }()
      
      // 시작 및 끝 날짜가 지정된 시간 간격 내에 있는 샘플에 대한 자료의 서술을 반환함
      let predicate = HKQuery.predicateForSamples(withStart: startDate,
                                                  end: endDate,
                                                  options: .strictStartDate)

      // 가져올 날짜 하루 단위 변수.
      let interval = DateComponents(hour: hourInterval)
      
      // 설정한 시간대에 대한 정보를 가져오는 query에 대한 결과문 반환
      let query = HKStatisticsCollectionQuery(quantityType: quantityType,
                                              quantitySamplePredicate: predicate,
                                              options: [.cumulativeSum],
                                              anchorDate: startDate,
                                              intervalComponents: interval)

      //query 첫 결과에 대한 hanlder
      query.initialResultsHandler = { query, results, error in
        if let error = error {
          completion(nil, nil, error)
          return
        }
        if let results = results {
          // 결과가 0일 때
          if results.statistics().count == 0 {
            completion(0, nil, nil)
          } else {
            // 시작 날짜부터 종료 날짜까지의 모든 시간 간격에 대한 통계 개체를 나열함.
            results.enumerateStatistics(from: startDate, to: endDate) { statistics, _ in
              // 데이터가 몇시의 것인지 알기 위해 시간을 Int로 저장
              let hour = Int(dateFormatter.string(from: statistics.startDate))
              
              // 쿼리와 일치하는 모든 값을 더함.
              if let quantity = statistics.sumQuantity() {
                let quantityValue = quantity.doubleValue(for: quantityFor)
                completion(quantityValue, hour, nil)
              } else {
                // 데이터가 없으므로 0을 넣어줌.
                completion(0, hour, nil)
              }
            }
          }
        } else {
          // 결과가 nil일 때
          print("HKStatisticsCollectionQuery failed!")
          completion(0, nil, nil)
        }
      }
      healthStore.execute(query)
    }
  }
}
