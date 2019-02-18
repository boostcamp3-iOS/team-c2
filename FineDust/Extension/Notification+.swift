//
//  Notification+.swift
//  FineDust
//
//  Created by Presto on 06/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

extension Notification {
  
  /// 위치 관련 작업 중 에러.
  var locationTaskError: LocationTaskError? {
    return userInfo?["error"] as? LocationTaskError
  }
}
