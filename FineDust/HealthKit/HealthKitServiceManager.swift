//
//  HealthKitServiceManager.swift
//  FineDust
//
//  Created by zun on 29/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit
import HealthKit

/// HealthKit Service를 총괄하는 Singleton 클래스.
final class HealthKitServiceManager {
  
  // MARK: - Properties
  
  static let shared = HealthKitServiceManager()
  
  /// Health 앱 데이터 권한을 요청하기 위한 프로퍼티.
  private let healthStore = HKHealthStore()
  
  /// Health 앱 데이터 중 걸음 수를 가져오기 위한 프로퍼티.
  private let stepCount = HKObjectType.quantityType(forIdentifier: .stepCount)
  
  /// Health 앱 데이터 중 걸은 거리를 가져오기 위한 프로퍼티.
  private let distance = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)
  
  /// Health App 권한을 나타내는 변수.
  private var isAuthorized = true
  
  // MARK: - Private Initializer
  
  private init() { }
  
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
      isAuthorized = false
      return
    }
    
    // 걸음 데이터를 얻기 위해 Set을 만든 다음 권한 요청.
    let healthKitTypes: Set = [stepCount, distance]
    
    // 권한요청.
    healthStore.requestAuthorization(toShare: healthKitTypes,
                                     read: healthKitTypes) { _, error in
      if let error = error {
        print("request authorization error : \(error.localizedDescription)")
      } else {
        print("complete request authorization")
      }
    }
  }
}

// MARK: - Protocol Implement

extension HealthKitServiceManager: HealthKitServiceManagerType {
  /// 권한이 없을경우 건강 App으로 이동시키는 메소드.
  func openHealth(_ viewController: UIViewController) {
    if !isAuthorized {
      // 앱 실행중 알람을 한번만 띄우게 하는 코드. isAuthorized는 이후로 false로 다시는 변경되지 않음.
      isAuthorized = true
      UIAlertController
        .alert(title: "건강 App에 대한 권한이 없습니다.",
               message: "App을 이용하려면 건강 App에 대한 권한이 필요합니다. 건강 -> 3번째 탭 데이터 소스 -> FineDust -> 권한허용을 해주세요")
        .action(title: "건강 App",
                style: .default) { _, _ in
          UIApplication.shared.open(URL(string: "x-apple-health://")!)
        }
        .action(title: "취소", style: .cancel, handler: nil)
        .present(to: viewController)
    }
  }
  
  /// HealthKit App의 특정 자료를 가져와 Label을 업데이트하는 UI 업데이트 메소드.
  func updateHealthKitLabel(label: UILabel,
                            quantityTypeIdentifier: HKQuantityTypeIdentifier) {
    var text: String?
    
    fetchHealthKitValue(quantityTypeIdentifier: quantityTypeIdentifier) {
      text = $0
    }
    
    DispatchQueue.main.async {
      if let text = text {
        label.text = text
      } else {
        label.text = "0"
      }
      
    }
  }
  
  /// label을 업데이트 시킬 적절한 string 값을 찾기 위해 초기 설정해주는 메소드.
  func fetchHealthKitValue(quantityTypeIdentifier: HKQuantityTypeIdentifier,
                           completion: @escaping (String) -> Void) {
    /// 걸음 혹은 걸은거리에 따른 적절한 String 리턴.
    var text: String = "" {
      didSet {
        completion(text)
      }
    }
    
    /// 걸음이냐 걸은 거리냐에 따른 단위를 설정하는 프로퍼티.
    let quantityFor: HKUnit
    
    /// findHealthKitValue에 보내줄 completion 프로퍼티.
    let sentCompletion: (Double) -> Void
    
    // Indentifier의 값이 걸음 혹은 걸은 거리이냐에 따라 변수들을 설정.
    if quantityTypeIdentifier == .stepCount {
      quantityFor = HKUnit.count()
      sentCompletion = {
        text = "\(Int($0)) 걸음"
      }
    } else {
      quantityFor = HKUnit.meter()
      sentCompletion = {
        text = String(format: "%.1f", $0.kilometer) + "km"
      }
    }
    
    // 위에서 설정한 값을 토대로 HealthKit App에서 값을 찾음.
    findHealthKitValue(startDate: Date.start(),
                       endDate: Date(),
                       quantityFor: quantityFor,
                       quantityTypeIdentifier: quantityTypeIdentifier,
                       completion: sentCompletion)
  }
  
  /// HealthKit App의 저장된 자료를 찾아주는 메소드.
  func findHealthKitValue(startDate: Date,
                          endDate: Date,
                          quantityFor: HKUnit,
                          quantityTypeIdentifier: HKQuantityTypeIdentifier,
                          completion: @escaping (Double) -> Void) {
    if let quantityType = HKQuantityType.quantityType(forIdentifier: quantityTypeIdentifier) {
      
      // 시작 및 끝 날짜가 지정된 시간 간격 내에 있는 샘플에 대한 자료의 서술을 반환함
      let predicate = HKQuery.predicateForSamples(withStart: startDate,
                                                  end: endDate,
                                                  options: .strictStartDate)
      
      // 가져올 날짜 단위 변수.
      var interval = DateComponents()
      interval.day = 1
      
      // 설정한 시간대에 대한 정보를 가져오는 query에 대한 결과문 반환
      let query = HKStatisticsCollectionQuery(quantityType: quantityType,
                                              quantitySamplePredicate: predicate,
                                              options: [.cumulativeSum],
                                              anchorDate: startDate,
                                              intervalComponents: interval)
      
      //query 첫 결과에 대한 hanlder
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
            results.enumerateStatistics(from: startDate, to: endDate) { statistics, _ in
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
}
