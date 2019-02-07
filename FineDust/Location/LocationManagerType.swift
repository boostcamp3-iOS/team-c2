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
      self.stopUpdatingLocation()
      let coordinate = location.coordinate
      let convertedCoordinate
        = GeoConverter()
          .convert(sourceType: .WGS_84,
                   destinationType: .TM,
                   geoPoint: GeographicPoint(x: coordinate.longitude,
                                             y: coordinate.latitude))
      SharedInfo.shared.set(x: convertedCoordinate?.x ?? 0, y: convertedCoordinate?.y ?? 0)
      GeocoderManager.shared.fetchAddress(location) { address, error in
        if let error = error {
          NotificationCenter.default
            .post(name: .didFailUpdatingAllLocationTasks,
                  object: nil,
                  userInfo: ["error": LocationTaskError.geoencodingError(error)])
          return
        }
        SharedInfo.shared.set(address: address ?? "")
        let dustObservatoryManager = DustObservatoryManager()
        dustObservatoryManager.fetchObservatory(numberOfRows: 1,
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
      NotificationCenter.default
        .post(name: .didFailUpdatingAllLocationTasks,
              object: nil,
              userInfo: ["error": LocationTaskError.coreLocationError(error)])
    }
  }
}
