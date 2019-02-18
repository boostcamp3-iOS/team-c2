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
  /// stepCount에 대한 권한과 distance에 관한 권한.
  var authorizationStatus: (HKAuthorizationStatus, HKAuthorizationStatus) { get }
  
  /// HealthKit 권한 요청 함수.
  func requestAuthorization()
  
  /// HealthKit App의 저장된 자료를 찾아주는 메소드.
  func findHealthKitValue(startDate: Date,
                          endDate: Date,
                          hourInterval: Int,
                          quantityFor: HKUnit,
                          identifier: HKQuantityTypeIdentifier,
                          completion: @escaping (Double?, Int?, Error?) -> Void)
}
