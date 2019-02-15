//
//  HealthKitError.swift
//  FineDust
//
//  Created by zun on 15/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

enum HealthKitError: Error {
  case notMatchingArguments
  
  case unexpectedIdentifier
  
  case queryNotValid
  
  case queryExecutedFailed
  
  case queryNotSearched
}
