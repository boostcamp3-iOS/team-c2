//
//  HealthKitServiceType.swift
//  FineDust
//
//  Created by zun on 29/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit
import HealthKit

protocol HealthKitServiceType {
  /// 권한이 없을경우 건강 App으로 이동시키는 메소드
  func openHealth(_ viewController: UIViewController)
  
  func findHealthKitValue(startDate: Date,
                          endDate: Date,
                          quantityFor: HKUnit,
                          quantityTypeIdentifier: HKQuantityTypeIdentifier,
                          completion: @escaping (Double) -> Void)
}
