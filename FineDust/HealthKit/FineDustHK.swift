//
//  FineDustHK.swift
//  FineDust
//
//  Created by zun on 24/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit
import HealthKit

class FineDustHK {
  
  // MARK: - Properties
  
  static let shared = FineDustHK()
  
  ///Health 앱 데이터 권한을 요청하기 위한 프로퍼티
  let healthStore = HKHealthStore()
  ///Health 앱 데이터 중 걸음을 가져오기 위한 프로퍼티
  let stepCount = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
  
  // MARK: - Methods
  
  private init() { }
  
  func requestAuthorization() {
    guard let stepCount = stepCount else {
      print("step count error")
      return
    }
    
    //권한이 없을 경우 사용자가 직접 허용을 해야하므로 건강 앱으로 이동
    if healthStore.authorizationStatus(for: stepCount) == .sharingDenied {
      if #available(iOS 10.0, *) {
        UIApplication.shared.open(URL(string: "x-apple-health://sources")!)
      }
      return
    }
    
    //걸음 데이터를 얻기 위해 Set을 만든 다음 권한 요청.
    let healthKitTypes: Set = [stepCount]
    
    healthStore.requestAuthorization(
      toShare: nil,
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
