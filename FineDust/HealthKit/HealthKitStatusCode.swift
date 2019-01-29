//
//  HealthKitStatusCode.swift
//  FineDust
//
//  Created by 이재은 on 29/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

struct HealthKitStatusCode {
  
  /// HealthKit 함수 호출 후 반환되는 상태값
  enum ResultCode: Int {
    // 성공
    case HKNoError = 0
    
    // 장치에서 제한 받음
    case HKErrorHealthDataUnavailable = 1
    
    // 장치에서 제한 받음
    case HKErrorHealthDataRestricted = 2
    
    // API에 유효하지 않은 인자가 들어옴
    case HKErrorInvalidArgument = 3
    
    // 요청한 작업에 대한 권한을 사용자가 거부함
    case HKErrorAuthorizationDenied = 4
    
    // 사용자가 권한을 결정하지 않음
    case HKErrorAuthorizationNotDetermined = 5
    
    // 필요한 데이터 타입에 접근하는 권한을 사용자가 거부함
    case HKErrorAuthorizaionDenied = 6
    
    // 데이터가 보호되고 있거나 장치가 잠겨있어 데이터를 이용할 수 없음
    case HKErrorDatabaseInaccesible = 7
    
    // 동작 중에 사용자가 취소함
    case HKErrorUserCanceld = 8
    
    // 세션이 시작될 때 다른 앱이 실행됨
    case HKErrorAnotherWorkoutSessionStarted = 9
    
    // 세션이 동작하고 있는 중에 사용자가 앱을 종료함
    case HKErrorUserExitedWorkoutSession = 10
  }
}
