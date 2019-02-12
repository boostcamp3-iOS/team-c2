//
//  AppDelegateError.swift
//  FineDust
//
//  Created by Presto on 01/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import CoreLocation
import Foundation

/// 앱델리게이트에서의 작업 중 에러 정의.
enum LocationTaskError: Error {
  
  /// 주소 변환 작업 중 에러.
  case geocodingError(CLError)
  
  /// 관측소 정보 받아오는 중 에러.
  case networkingError(DustError)
  
  /// 코어 로케이션 작업 중 에러.
  case coreLocationError(CLError)
  
  var localizedDescription: String {
    switch self {
    case let .geocodingError(error):
      return error.localizedDescription
    case let .networkingError(error):
      return error.localizedDescription
    case let .coreLocationError(error):
      return error.localizedDescription
    }
  }
}
