//
//  HTTPError.swift
//  FineDust
//
//  Created by Presto on 29/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// HTTP 통신 에러.
enum HTTPError: ServiceErrorType {
  
  /// 200이 아닌 나머지.
  case `default`
}

// MARK: - 에러 디스크립션

extension HTTPError {
  
  var localizedDescription: String {
    switch self {
    case .default:
      return "네트워크 연결을 확인해 주세요."
    }
  }
}
