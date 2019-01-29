//
//  HealthKitServiceManager.swift
//  FineDust
//
//  Created by zun on 29/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

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
  
  
  
}
