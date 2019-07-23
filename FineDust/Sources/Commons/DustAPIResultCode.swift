//
//  FineDustCode.swift
//  FineDust
//
//  Created by Presto on 29/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

enum DustAPIResultCode: Int {
  
  case success = 0
  
  case applicationError = 1
  
  case dbError = 2
  
  case noData = 3
  
  case httpError = 4
  
  case serviceTimeOut = 5
  
  case invalidRequestParameter = 10
  
  case noRequiredRequestParameter = 11
  
  case noServiceOrDeprecated = 12
  
  case accessDenied = 20
  
  case exceededRequestLimit = 22
  
  case unregisteredServiceKey = 30
  
  case expiredServiceKey = 31
  
  case unregisteredDomainOfIPAddress = 32
  
  case none
}

extension DustAPIResultCode {
  
  var error: DustAPIError? {
    switch self {
    case .success:
      return nil
    case .applicationError:
      return .applicationError
    case .dbError:
      return .dbError
    case .noData:
      return .noData
    case .httpError:
      return .httpError
    case .serviceTimeOut:
      return .serviceTimeOut
    case .invalidRequestParameter:
      return .invalidRequestParameter
    case .noRequiredRequestParameter:
      return .noRequiredRequestParameter
    case .noServiceOrDeprecated:
      return .noServiceOrDeprecated
    case .accessDenied:
      return .accessDenied
    case .exceededRequestLimit:
      return .exceededRequestLimit
    case .unregisteredServiceKey:
      return .unregisteredServiceKey
    case .expiredServiceKey:
      return .expiredServiceKey
    case .unregisteredDomainOfIPAddress:
      return .unregisteredDomainOfIPAddress
    case .none:
      return .none
    }
  }
}
