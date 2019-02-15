//
//  HealthKitManagerType.swift
//  FineDust
//
//  Created by zun on 01/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation
import HealthKit

/// HealthKit Manager Type.
protocol HealthKitManagerType: class {
  /// HealthKit App의 저장된 자료를 찾아주는 메소드.
  func findHealthKitValue(startDate: Date,
                          endDate: Date,
                          hourInterval: Int,
                          quantityFor: HKUnit,
                          quantityTypeIdentifier: HKQuantityTypeIdentifier,
                          completion: @escaping (Double?, Int?, Error?) -> Void)
  
  /// HealthKit 권한 요청 함수.
  func requestAuthorization()
  
  var authorizationStatus: (HKAuthorizationStatus, HKAuthorizationStatus) { get }
}
