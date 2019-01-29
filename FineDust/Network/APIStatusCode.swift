//
//  APIError.swift
//  FineDust
//
//  Created by Presto on 28/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

struct APIStatusCode {
  
  /// 미세먼지 API가 내려주는 Result Code
  enum ResultCode: Int {
    
    /// 성공
    case success = 0
    
    /// 제공기관 서비스 상태가 원활하지 않음
    case applicationError = 1
    
    /// 제공기관 서비스 제공 상태가 원활하지 않음
    case dbError = 2
    
    /// 데이터 없음
    case noData = 3
    
    /// 제공기관 서비스 제공 상태가 원활하지 않음
    case httpError = 4
    
    /// 제공기관 서비스 제공 상태가 원활하지 않음
    case serviceTimeOut = 5
    
    /// Open API 요청시 ServiceKey 파라미터가 없음
    case invalidRequestParameter = 10
    
    /// 요청한 Open API의 필수 파라미터가 누락됨
    case noRequiredRequestParameter = 11
    
    /// Open API 호출시 URL이 잘못됨
    case noServiceOfDeprecated = 12
    
    /// 활용승인이 되지 않은 Open API 호출
    case accessDenied = 20
    
    /// 일일 활용건수가 초과함
    case exceededRequestLimit = 22
    
    /// 잘못된 서비스키를 사용하였거나 서비스키를 URL 인코딩하지 않음
    case unregisteredServiceKey = 30
    
    /// Open API 사용기간이 만료됨
    case expiredServiceKey = 31
    
    /// 활용신청한 서버의 IP와 실제 Open API 호출한 서버가 다름
    case unregisteredDomainOfIPAddress = 32
  }
  
  /// 네트워킹에 대한 상태 코드
  enum StatusCode: Int {
    
    /// 성공
    case success = 200
    
    /// 나머지 - 오류
    case `default`
  }
  
  let code: (statusCode: StatusCode, resultCode: ResultCode)
  
  var isSuccess: Bool {
    return code.statusCode == .success && code.resultCode == .success
  }
}
