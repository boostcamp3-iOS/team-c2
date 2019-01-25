//
//  Notification.Name+.swift
//  FineDust
//
//  Created by Presto on 25/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

extension Notification.Name {
  
  static let fetchObservatoryDidSuccess = Notification.Name("fetchObservatoryDidSuccess")
  
  static let fetchFineDustConcentrationDidSuccess
    = Notification.Name("fetchFineDustConcentrationDidSuccess")
  
  static let fetchObservatoryDidError = Notification.Name("fetchObservatoryDidError")
  
  static let fetchFineDustConcentrationDidError
    = Notification.Name("fetchFineDustConcentrationDidError")
}
