//
//  HTTPStatusCode.swift
//  FineDust
//
//  Created by Presto on 29/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

/// 네트워킹에 대한 상태 코드.
enum HTTPStatusCode: Int {
  
  /// 성공.
  case success = 200
  
  /// 나머지.
  case `default`
  
  var error: HTTPError? {
    switch self {
    case .default:
      return .default
    default:
      return nil
    }
  }
}
