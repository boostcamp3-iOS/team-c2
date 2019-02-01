//
//  FineDustCode.swift
//  FineDust
//
//  Created by Presto on 29/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

/// 미세먼지 API가 내려주는 Result Code.
enum FineDustStatusCode: Int {
  
  /// 성공.
  case success = 0
  
  /// 제공기관 서비스 상태가 원활하지 않음.
  case applicationError = 1
  
  /// 제공기관 서비스 제공 상태가 원활하지 않음.
  case dbError = 2
  
  /// 데이터 없음.
  case noData = 3
  
  /// 제공기관 서비스 제공 상태가 원활하지 않음.
  case httpError = 4
  
  /// 제공기관 서비스 제공 상태가 원활하지 않음.
  case serviceTimeOut = 5
  
  /// Open API 요청시 ServiceKey 파라미터가 없음.
  case invalidRequestParameter = 10
  
  /// 요청한 Open API의 필수 파라미터가 누락됨.
  case noRequiredRequestParameter = 11
  
  /// Open API 호출시 URL이 잘못됨.
  case noServiceOrDeprecated = 12
  
  /// 활용승인이 되지 않은 Open API 호출.
  case accessDenied = 20
  
  /// 일일 활용건수가 초과함.
  case exceededRequestLimit = 22
  
  /// 잘못된 서비스키를 사용하였거나 서비스키를 URL 인코딩하지 않음.
  case unregisteredServiceKey = 30
  
  /// Open API 사용기간이 만료됨.
  case expiredServiceKey = 31
  
  /// 활용신청한 서버의 IP와 실제 Open API 호출한 서버가 다름.
  case unregisteredDomainOfIPAddress = 32
  
  /// 나머지.
  case `default`
  
  /// 각 상태 코드에 대응하는 에러.
  var error: FineDustError? {
    switch self {
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
    case .default:
      return .default
    default:
      return nil
    }
  }
}
