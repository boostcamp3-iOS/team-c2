//
//  LocationObserver.swift
//  FineDust
//
//  Created by Presto on 06/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation
import UIKit

/// 위치 정보 관련 옵저버 프로토콜.
///
/// `registerLocationObserver()` 메소드를 `viewDidLoad()`에서 호출하여 옵저버 등록.
/// `unregisterLocationObserver()` 메소드를 `deinit`에서 호출하여 옵저버 해제.
protocol LocationObserver: class {
  
  /// 위치 정보 갱신 작업이 성공했을 때의 핸들러.
  func handleIfSuccess(_ notification: Notification)
  
  /// 위치 정보 갱신 작업이 실패했을 때의 핸들러.
  func handleIfFail(_ notification: Notification)
  
  /// 위치 정보 권한이 허용되지 않았을 때의 핸들러.
  func handleIfAuthorizationDenied(_ notification: Notification)
  
  /// 위치 정보 옵저버 등록.
  func registerLocationObserver()
  
  /// 위치 정보 옵저버 해제.
  func unregisterLocationObserver()
}

// MARK: - LocationObserver 프로토콜 초기 구현

extension LocationObserver where Self: UIViewController {
  
  func handleIfFail(_ notification: Notification) {
    if let error = notification.locationTaskError {
      errorLog(error.localizedDescription)
      Banner.show(title: error.localizedDescription)
    }
  }
  
  func handleIfAuthorizationDenied(_ notification: Notification) {
    if let error = notification.locationTaskError {
      errorLog(error.localizedDescription)
      Banner.show(title: error.localizedDescription)
    }
  }
  
  /// 위의 세 경우에 대한 옵저버 등록.
  func registerLocationObserver() {
    NotificationCenter.default.addObserver(
      forName: .didSuccessUpdatingAllLocationTasks,
      object: nil,
      queue: nil) { [weak self] notification in
        self?.handleIfSuccess(notification)
    }
    NotificationCenter.default.addObserver(
      forName: .didFailUpdatingAllLocationTasks,
      object: nil,
      queue: nil) { [weak self] notification in
        self?.handleIfFail(notification)
    }
    NotificationCenter.default.addObserver(
      forName: .locationPermissionDenied,
      object: nil,
      queue: nil) { [weak self] notification in
        self?.handleIfAuthorizationDenied(notification)
    }
  }
  
  /// 위의 세 경우에 대한 옵저버 해제.
  func unregisterLocationObserver() {
    NotificationCenter.default.removeObserver(
      self,
      name: .didSuccessUpdatingAllLocationTasks,
      object: nil
    )
    NotificationCenter.default.removeObserver(
      self,
      name: .didFailUpdatingAllLocationTasks,
      object: nil
    )
    NotificationCenter.default.removeObserver(
      self,
      name: .locationPermissionDenied,
      object: nil
    )
  }
}
