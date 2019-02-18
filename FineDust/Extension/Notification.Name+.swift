//
//  Notification.Name+.swift
//  FineDust
//
//  Created by Presto on 25/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

extension Notification.Name {

  /// 위치정보 갱신 작업 완료 노티피케이션.
  static let didSuccessUpdatingAllLocationTasks
    = Notification.Name("didSuccessUpdatingAllLocationTasks")
  
  /// 위치정보 갱신 작업중 실패 노티피케이션.
  static let didFailUpdatingAllLocationTasks = Notification.Name("didFailUpdatingAllLocationTasks")
  
  /// 위치정보 권한 성공 이외 노티피케이션.
  static let locationPermissionDenied = Notification.Name("locationPermissionDenied")
  
  /// HealthKit 권한 허용 노티피케이션.
  static let healthKitAuthorizationSharingAuthorized
    = Notification.Name("healthKitAuthorizationSharingAuthorized")
}
