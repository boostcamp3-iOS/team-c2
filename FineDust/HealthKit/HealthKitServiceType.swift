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
  ///Health App으로 이동시켜주는 메소드
  func openHealth(_ viewController: UIViewController)
  func findHealthKitValue(startDate: Date,
                          endDate: Date,
                          quantityFor: HKUnit,
                          quantityTypeIdentifier: HKQuantityTypeIdentifier,
                          completion: @escaping (Double) -> Void)
  
}
