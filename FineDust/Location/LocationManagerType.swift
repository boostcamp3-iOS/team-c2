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

// MARK: - LocationManagerType 프로토콜 초기 구현

extension LocationManagerType {
  
  var authorizationChangingHandler: ((CLAuthorizationStatus) -> Void)? {
    return { status in
      // 권한이 허용이 되면 위치 정보 갱신을 시작함
      // 권한이 거부되면 관련 상태를 포함하여 노티피케이션을 쏴줌
      switch status {
      case .authorizedAlways, .authorizedWhenInUse:
        self.startUpdatingLocation()
      default:
        NotificationCenter.default
          .post(name: .locationPermissionDenied, object: nil, userInfo: ["status": status])
      }
    }
  }
  
  var locationUpdatingHandler: ((CLLocation) -> Void)? {
    return { location in
      // 위치 정보 갱신이 완료되면
      // 일단 위치 정보 갱신을 멈춘다
      // 이후 GeoConverter 오픈소스 활용하여 좌표를 변환하고
      // SharedInfo 싱글톤 객체에 x y 좌표를 저장한다
      // GeocoderManager 활용하여 좌표로부터 주소를 얻고 주소를 SharedInfo 싱글톤 객체에 저장한다
      // DustObservatoryManager 활용하여 관측소 정보를 얻고 SharedInfo 싱글톤 객체에 젖아한다
      // 모든 작업이 완료되었으면 완료되었다는 노티피케이션을 쏴준다
      // 작업 도중에 에러가 발생하면 관련 에러를 포함하여 노티피케이션을 쏴준다
      self.stopUpdatingLocation()
      let coordinate = location.coordinate
      let convertedCoordinate
        = GeoConverter()
          .convert(sourceType: .WGS_84,
                   destinationType: .TM,
                   geoPoint: GeographicPoint(x: coordinate.longitude,
                                             y: coordinate.latitude))
      SharedInfo.shared.set(x: convertedCoordinate?.x ?? 0, y: convertedCoordinate?.y ?? 0)
      GeocoderManager.shared.requestAddress(location) { address, error in
        if let error = error {
          NotificationCenter.default
            .post(name: .didFailUpdatingAllLocationTasks,
                  object: nil,
                  userInfo: ["error": LocationTaskError.geoencodingError(error)])
          return
        }
        SharedInfo.shared.set(address: address ?? "")
        let dustObservatoryManager = DustObservatoryManager()
        dustObservatoryManager.requestObservatory(numberOfRows: 1,
                                                pageNumber: 1) { response, error in
          if let error = error {
            NotificationCenter.default
              .post(name: .didSuccessUpdatingAllLocationTasks,
                    object: nil,
                    userInfo: ["error": LocationTaskError.networkingError(error)])
            return
          }
          guard let observatory = response?.observatory else { return }
          SharedInfo.shared.set(observatory: observatory)
          NotificationCenter.default.post(name: .didSuccessUpdatingAllLocationTasks, object: nil)
        }
      }
    }
  }
  
  var errorHandler: ((Error) -> Void)? {
    return { error in
      // Core Location 작업 중 에러가 발생하면 관련 에러를 포함하여 노티피케이션을 쏴준다
      NotificationCenter.default
        .post(name: .didFailUpdatingAllLocationTasks,
              object: nil,
              userInfo: ["error": LocationTaskError.coreLocationError(error)])
    }
  }
}
