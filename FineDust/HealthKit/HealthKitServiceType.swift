//
//  HealthKitServiceType.swift
//  FineDust
//
//  Created by zun on 29/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit
import HealthKit

protocol HealthKitServiceType: class {
  /// 권한이 없을경우 건강 App으로 이동시키는 메소드
  func openHealth(_ viewController: UIViewController)
  
  /// HealthKit App의 특정 자료를 가져와 label을 업데이트하는 메소드.
  func fetchHealthKitValue(label: UILabel,
                           quantityTypeIdentifier: HKQuantityTypeIdentifier)
  
  /// HealthKit App의 저장된 자료를 찾아주는 메소드.
  func findHealthKitValue(startDate: Date,
                          endDate: Date,
                          quantityFor: HKUnit,
                          quantityTypeIdentifier: HKQuantityTypeIdentifier,
                          completion: @escaping (Double) -> Void)
}
