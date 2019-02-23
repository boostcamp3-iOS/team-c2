//
//  CoreDataError.swift
//  FineDust
//
//  Created by Presto on 19/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// 코어데이터 에러 정의.
enum CoreDataError: ServiceErrorType {
  
  /// 저장된 User가 없음.
  case noUser
  
  /// 에러 디스크립션.
  var localizedDescription: String {
    switch self {
    case .noUser:
      return "등록된 사용자가 없습니다."
    }
  }
}
