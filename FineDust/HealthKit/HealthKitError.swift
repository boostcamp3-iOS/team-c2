//
//  HealthKitError.swift
//  FineDust
//
//  Created by zun on 15/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

enum HealthKitError: ServiceErrorType {
  var localizedDescription: String {
    switch self {
    case .notMatchingArguments:
      return "알 수 없는 에러가 발생했습니다.".localized
    case .unexpectedIdentifier:
      return "알 수 없는 에러가 발생했습니다.".localized
    case .queryNotValid:
      return "건강 App 권한이 아직 설정되지 않았습니다.".localized
    case .queryNotSearched:
      return "건강 App 권한이 없습니다.".localized
    case .queryExecutedFailed:
      return "query문 실행이 실패했습니다.".localized
    case .notAuthorized:
      return "건강 App 권한이 없습니다.".localized
    }
  }
  
  /// HealthKitManager의 파라미터 값들이 .stepCount - .count() 와
  /// .distanceWalkingRunning - .meter() 짝으로 오지 않을때 에러.
  case notMatchingArguments
  
  /// HealthKitManager의 indentifier 인자 값이 예상치 못한 값이 들어올때의 에러.
  case unexpectedIdentifier
  
  /// HealthKit query를 만들때 생기는 에러. 권한이 결정되지 않았을때도 발생.
  case queryNotValid

  /// HealthKit query가 실행하는데 실패했을 경우.
  case queryExecutedFailed
  
  /// query는 만들어지긴 하나 결과가 없을때. 권한이 없을때도 발생.
  case queryNotSearched
  
  /// 권한이 없음.
  case notAuthorized
}
