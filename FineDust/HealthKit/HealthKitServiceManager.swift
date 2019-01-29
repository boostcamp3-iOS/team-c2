//
//  HealthKitServiceManager.swift
//  FineDust
//
//  Created by zun on 29/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit
import HealthKit

/// HealthKit Service를 총괄하는 Singleton 클래스
final class HealthKitServiceManager {
  
  // MARK: - Properties
  
  static let shared = HealthKitManager()
  
  ///Health 앱 데이터 권한을 요청하기 위한 프로퍼티
  private let healthStore = HKHealthStore()
  
  ///Health 앱 데이터 중 걸음 수를 가져오기 위한 프로퍼티
  private let stepCount = HKObjectType.quantityType(
    forIdentifier: HKQuantityTypeIdentifier.stepCount
  )
  
  ///Health 앱 데이터 중 걸은 거리를 가져오기 위한 프로퍼티
  private let distance = HKObjectType.quantityType(
    forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning
  )
  
  ///Health App 권한을 나타내는 변수
  private var isAuthorized = true
  
  // MARK: - Private Initializer
  
  private init() { }
  
  // MARK : Method
  
  ///App 시작시 권한을 얻기 위한 메소드
  func requestAuthorization() {
    guard let stepCount = stepCount else {
      print("step count request error")
      return
    }
    guard let distance = distance else {
      print("distance request error")
      return
    }
    
    //권한이 없을 경우 사용자가 직접 허용을 해야하게끔 해주기 위해 변수를 false로 설정
    if healthStore.authorizationStatus(for: stepCount) == .sharingDenied
      || healthStore.authorizationStatus(for: distance) == .sharingDenied {
      isAuthorized = false
      return
    }
    
    //걸음 데이터를 얻기 위해 Set을 만든 다음 권한 요청.
    let healthKitTypes: Set = [stepCount, distance]
    
    healthStore.requestAuthorization(
      toShare: healthKitTypes,
      read: healthKitTypes
    ) { _, error in
      if let err = error {
        print("request authorization error : \(err.localizedDescription)")
      } else {
        print("complete request authorization")
      }
    }
  }
}

