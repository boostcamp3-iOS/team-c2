//
//  FineDustError.swift
//  FineDust
//
//  Created by Presto on 29/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

enum DustAPIError: ServiceErrorType {
  
  case applicationError
  
  case dbError
  
  case noData
  
  case httpError
  
  case serviceTimeOut
  
  case invalidRequestParameter
  
  case noRequiredRequestParameter
  
  case noServiceOrDeprecated
  
  case accessDenied
  
  case exceededRequestLimit
  
  case unregisteredServiceKey
  
  case expiredServiceKey
  
  case unregisteredDomainOfIPAddress
  
  case `default`
}

extension DustAPIError {
  
  var localizedDescription: String {
    switch self {
    case .applicationError, .dbError, .httpError, .serviceTimeOut:
      return "제공기관 서비스 상태가 원활하지 않습니다."
    case .noData:
      return "데이터가 없습니다."
    case .invalidRequestParameter:
      return "ServiceKey 파라미터가 누락되었습니다."
    case .noRequiredRequestParameter:
      return "필수 파라미터가 누락되었습니다."
    case .noServiceOrDeprecated:
      return "호출 URL이 잘못되었습니다."
    case .accessDenied:
      return "활용 승인이 되지 않은 호출을 하였습니다."
    case .exceededRequestLimit:
      return "일일 활용건수를 초과하였습니다."
    case .unregisteredServiceKey:
      return "잘못된 서비스키를 사용하였거나 서비스키를 URL 인코딩하지 않았습니다."
    case .expiredServiceKey:
      return "API 사용기간이 만료되었습니다."
    case .unregisteredDomainOfIPAddress:
      return "활용신청한 서버의 IP와 실제 Open API를 호출한 서버가 다릅니다."
    case .default:
      return "미세먼지 정보를 가져오지 못했습니다."
    }
  }
}
