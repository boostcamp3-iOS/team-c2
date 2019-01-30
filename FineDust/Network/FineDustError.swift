//
//  FineDustError.swift
//  FineDust
//
//  Created by Presto on 29/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

enum FineDustError: Error {
  
  /// 제공기관 서비스 상태가 원활하지 않음.
  case applicationError
  
  /// 제공기관 서비스 제공 상태가 원활하지 않음.
  case dbError
  
  /// 데이터 없음.
  case noData
  
  /// 제공기관 서비스 제공 상태가 원활하지 않음.
  case httpError
  
  /// 제공기관 서비스 제공 상태가 원활하지 않음.
  case serviceTimeOut
  
  /// Open API 요청시 ServiceKey 파라미터가 없음.
  case invalidRequestParameter
  
  /// 요청한 Open API의 필수 파라미터가 누락됨.
  case noRequiredRequestParameter
  
  /// Open API 호출시 URL이 잘못됨.
  case noServiceOrDeprecated
  
  /// 활용승인이 되지 않은 Open API 호출.
  case accessDenied
  
  /// 일일 활용건수가 초과함.
  case exceededRequestLimit
  
  /// 잘못된 서비스키를 사용하였거나 서비스키를 URL 인코딩하지 않음.
  case unregisteredServiceKey
  
  /// Open API 사용기간이 만료됨.
  case expiredServiceKey
  
  /// 활용신청한 서버의 IP와 실제 Open API 호출한 서버가 다름.
  case unregisteredDomainOfIPAddress
  
  /// 나머지.
  case `default`
}

// MARK: - 에러 디스크립션

extension FineDustError: LocalizedError {
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
      return "알 수 없는 오류가 발생하였습니다."
    }
  }
}
