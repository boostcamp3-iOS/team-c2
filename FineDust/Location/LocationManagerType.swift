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
  
  /// 권한 상태 변경시 실행될 핸들러.
  var authorizationChangingHandler: ((CLAuthorizationStatus) -> Void)? { get set }
  
  /// 위치 정보 갱신시 실행될 핸들러.
  var locationUpdatingHandler: ((CLLocation) -> Void)? { get set }
  
  /// 에러 발생시 실행될 핸들러.
  var errorHandler: ((Error) -> Void)? { get set }
  
  /// Location Manager 구성 설정.
  /// `authorizationChangeHandler`, `locationUpdateHandler`, `errorHandler` 구성.
  func configure(_ configurationHandler: @escaping (LocationManagerType) -> Void)
  
  /// 권한 요청.
  func requestAuthorization()
  
  /// 위치 정보 갱신 시작.
  func startUpdatingLocation()
  
  /// 위치 정보 갱신 중단.
  func stopUpdatingLocation()
}
