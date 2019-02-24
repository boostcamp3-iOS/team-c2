//
//  LocationManagerType.swift
//  FineDust
//
//  Created by Presto on 31/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import CoreLocation
import Foundation

/// Location Manager 프로토콜.
protocol LocationManagerType: class {
  
  /// 위치 권한.
  var authorizationStatus: CLAuthorizationStatus { get }
  
  /// 권한 상태 변경시 실행될 핸들러.
  var authorizationChangingHandler: ((CLAuthorizationStatus) -> Void)? { get }
  
  /// 위치 정보 갱신시 실행될 핸들러.
  var locationUpdatingHandler: ((CLLocation) -> Void)? { get }
  
  /// 에러 발생시 실행될 핸들러.
  var errorHandler: ((Error) -> Void)? { get }
  
  /// 권한 요청.
  func requestAuthorization()
  
  /// 위치 정보 갱신 시작.
  func startUpdatingLocation()
  
  /// 위치 정보 갱신 중단.
  func stopUpdatingLocation()
}
