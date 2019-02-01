//
//  HealthKitManagerType.swift
//  FineDust
//
//  Created by zun on 01/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

protocol HealthKitManagerType: class {
  func fetchStepCount(startDate: Date, endDate: Date, completion: @escaping (Double?) -> Void) 
  func fetchDistance(startDate: Date, endDate: Date, completion: @escaping (Double?) -> Void)
}
