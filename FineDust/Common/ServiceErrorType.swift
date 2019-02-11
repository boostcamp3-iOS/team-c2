//
//  ServiceErrorType.swift
//  FineDust
//
//  Created by Presto on 11/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation
import UIKit

/// 서비스 메소드에서 나올 수 있는 사용자 정의 에러 타입.
protocol ServiceErrorType: Error {
  
  /// 에러를 얼러트에 표시하기 위한 프로퍼티.
  var alert: UIAlertController { get }
}

// MARK: - ServiceErrorType 프로토콜 초기 구현

extension ServiceErrorType {
  
  var localizedDescription: String {
    switch self {
    case let error as HTTPError:
      return error.localizedDescription
    case let error as XMLError:
      return error.localizedDescription
    case let error as DustError:
      return error.localizedDescription
    default:
      return "에러"
    }
  }
  
  var alert: UIAlertController {
    return UIAlertController.alert(title: "", message: localizedDescription).action(title: "확인")
  }
}
