//
//  HealthKitManager.swift
//  FineDust
//
//  Created by 이재은 on 28/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation
import HealthKit

protocol HealthKitManagerType {
  func findHealthKitValue(
    startDate: Date,
    endDate: Date,
    quantityFor: HKUnit,
    quantityTypeIdentifier: HKQuantityTypeIdentifier,
    completion: @escaping (_ quantityValue: Double) -> Void)
  func returnDistanceValue(_ completion: @escaping (Double) -> Void)
  func returnStepCountValue(_ completion: @escaping (Double) -> Void)
}

struct HealthKitManager: HealthKitManagerType {
  // HealthKit Data에 접근하는 지점.
  fileprivate let healthStore = HKHealthStore()
  fileprivate let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
  let startDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())
  let endDate = Date()
  
  /// HealthKit 값 가져오는 함수.
  func findHealthKitValue(
    startDate: Date,
    endDate: Date,
    quantityFor: HKUnit,
    quantityTypeIdentifier: HKQuantityTypeIdentifier,
    completion: @escaping (Double) -> Void
  ) {
    if let quantityType = HKQuantityType.quantityType(forIdentifier: quantityTypeIdentifier) {
      // 시작 및 끝 날짜가 지정된 시간 간격 내에 있는 샘플에 대한 서술을 반환함
      let predicate = HKQuery.predicateForSamples(
        withStart: startDate,
        end: endDate,
        options: .strictStartDate)
      
      // 가져올 날짜 단위 변수.
      var interval: DateComponents = DateComponents()
      interval.day = 1
      
      // 정한 시간에 대한 통계 쿼리를 수행하고 결과를 반환함.
      let query = HKStatisticsCollectionQuery(quantityType: quantityType,
                                              quantitySamplePredicate: predicate,
                                              options: [.cumulativeSum],
                                              anchorDate: startDate,
                                              intervalComponents: interval)
      
      query.initialResultsHandler = { query, results, error in
        if error != nil {
          print("findHealthKitValue error: \(String(describing: error?.localizedDescription))")
          return
        }
        if let results = results {
          if results.statistics().count == 0 {
            completion(0)
          } else {
            // 시작 날짜부터 종료 날짜까지의 모든 시간 간격에 대한 통계 개체를 나열함.
            results.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
              // 쿼리와 일치하는 모든 값을 더함.
              if let quantity = statistics.sumQuantity() {
                let quantityValue = quantity.doubleValue(for: quantityFor)
                completion(quantityValue)
              }
            }
          }
        } else {
          print("HKStatisticsCollectionQuery failed!")
        }
      }
      healthStore.execute(query)
    }
  }
  
  /// 걸은 거리 반환하기.
  func returnDistanceValue(_ completion: @escaping (Double) -> Void) {
    guard let startDate = startDate else { return }
    
    findHealthKitValue(
      startDate: startDate,
      endDate: endDate,
      quantityFor: HKUnit.meter(),
      quantityTypeIdentifier: .distanceWalkingRunning,
      completion: completion
    )
  }
  
  /// 걸음 수 반환하기.
  func returnStepCountValue(_ completion: @escaping (Double) -> Void) {
    guard let startDate = startDate else { return }
    
    findHealthKitValue(
      startDate: startDate,
      endDate: endDate,
      quantityFor: HKUnit.count(),
      quantityTypeIdentifier: .stepCount,
      completion: completion
    )
  }
}
