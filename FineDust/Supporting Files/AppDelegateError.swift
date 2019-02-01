//
//  AppDelegateError.swift
//  FineDust
//
//  Created by Presto on 01/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// 앱델리게이트에서의 작업 중 에러 정의.
enum AppDelegateError: Error {
  
  /// 주소 변환 작업 중 에러.
  case geoencodingError(Error)
  
  /// 관측소 정보 받아오는 중 에러.
  case networkingError(Error)
  
  /// 코어 로케이션 작업 중 에러.
  case coreLocationError(Error)
}
