//
//  HealthKitServiceType.swift
//  FineDust
//
//  Created by 이재은 on 01/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation
import HealthKit

protocol HealthKitServiceType: class {
  func fetchStepCount(startDate: Date, endDate: Date, completion: @escaping (Double?) -> Void)
  func fetchDistance(startDate: Date, endDate: Date, completion: @escaping (Double?) -> Void)
}
