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
  private let stepCount = HKObjectType.quantityType(forIdentifier: .stepCount)!
  
  /// Health 앱 데이터 중 걸은 거리를 가져오기 위한 프로퍼티.
  private let distance = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!
  
  /// stepCount에 대한 권한과 distance에 관한 권한.
  var authorizationStatus: (HKAuthorizationStatus, HKAuthorizationStatus) {
    return (healthStore.authorizationStatus(for: stepCount),
            healthStore.authorizationStatus(for: distance))
  }
  
  // MARK: - Methods
  
  /// App 시작시 Health App 정보 접근권한을 얻기 위한 메소드.
  func requestAuthorization() {
    // 걸음 데이터를 얻기 위해 Set을 만든 다음 권한 요청.
    let healthKitTypes: Set = [stepCount, distance]
    
    // 권한요청.
    healthStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) { _, error in
      if let error = error {
        errorLog("request authorization error : \(error.localizedDescription)")
        Banner.show(title: error.localizedDescription)
      } else {
        // 권한 요청이 끝난 후 실행되는 completion handler.
        debugLog("complete request HealthKit authorization")
        
        if self.authorizationStatus == (.sharingAuthorized, .sharingAuthorized) {
          NotificationCenter.default.post(
            name: .healthKitAuthorizationSharingAuthorized,
            object: nil)
        }
      }
    }
  }
  
  /// HealthKit App의 저장된 자료를 찾아주는 메소드.
  /// - Parameter completion: value, hour, error
  func findHealthKitValue(startDate: Date,
                          endDate: Date,
                          hourInterval: Int,
                          quantityFor: HKUnit,
                          identifier: HKQuantityTypeIdentifier,
                          completion: @escaping (Double?, Int?, Error?) -> Void) {
    if !(identifier == .stepCount && quantityFor == .count() ||
      identifier == .distanceWalkingRunning && quantityFor == .meter()) {
      errorLog("findHealthKitValue의 파라미터 값이 서로 맞지 않습니다.")
      completion(nil, nil, HealthKitError.notMatchingArguments)
      return
    }
    
    guard let quantityType = HKQuantityType.quantityType(forIdentifier: identifier) else {
      errorLog("예상치 못한 findHealthKitValue의 파라미터값이 들어왔습니다.")
      completion(nil, nil, HealthKitError.unexpectedIdentifier)
      return
    }
    
    let dateFormatter: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateFormat = "HH"
      return formatter
    }()
    
    // 가져올 날짜 하루 단위 변수.
    let interval = DateComponents(hour: hourInterval)
    
    // 시작 및 끝 날짜가 지정된 시간 간격 내에 있는 샘플에 대한 자료의 서술을 반환함
    let predicate = HKQuery.predicateForSamples(withStart: startDate,
                                                end: endDate,
                                                options: .strictStartDate)
    
    // 설정한 시간대에 대한 정보를 가져오는 query에 대한 결과문 반환
    let query = HKStatisticsCollectionQuery(quantityType: quantityType,
                                            quantitySamplePredicate: predicate,
                                            options: [.cumulativeSum],
                                            anchorDate: startDate,
                                            intervalComponents: interval)
    
    // query 첫 결과에 대한 hanlder
    query.initialResultsHandler = { query, results, error in
      // query가 유효하지 않을 경우.
      if let error = error {
        errorLog("query문이 유효하지 않습니다.")
        errorLog(error.localizedDescription)
        completion(nil, nil, HealthKitError.queryNotValid)
        return
      }
      
      if let results = results {
        // 쿼리가 검색되지 않을때. 대부분 권한이 없을때 실행된다.
        if results.statistics().count == 0 {
          errorLog("query 결과가 없습니다.")
          completion(nil, nil, HealthKitError.queryNotSearched)
        } else {
          // 시작 날짜부터 종료 날짜까지의 시간 간격에 대한 통계 개체만큼 handler가 수행됨.
          results.enumerateStatistics(from: startDate, to: endDate) { statistics, _ in
            
            // 데이터가 몇시의 것인지 알기 위해 시간을 Int로 저장
            let hour = Int(dateFormatter.string(from: statistics.startDate))
            
            // 쿼리와 일치하는 모든 값을 더함.
            if let quantity = statistics.sumQuantity() {
              let quantityValue = quantity.doubleValue(for: quantityFor)
              completion(quantityValue, hour, nil)
            } else {
              // 유효한 데이터가 없으므로 0을 삽입.
              completion(0, hour, nil)
            }
          }
        }
      } else {
        // query 실행이 실패하여 결과값이 없을 경우.
        errorLog("query 실행에 실패하였습니다.")
        completion(nil, nil, HealthKitError.queryExecutedFailed)
      }
    }
    healthStore.execute(query)
  }
}
