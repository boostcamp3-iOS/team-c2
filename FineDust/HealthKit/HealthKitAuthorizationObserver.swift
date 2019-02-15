//
//  HealthKitAuthorizationObserver.swift
//  FineDust
//
//  Created by zun on 14/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation
import UIKit

protocol HealthKitAuthorizationObserver: class {
  func authorizationNotDetermined(_ notification: Notification)
  
  func authorizationSharingDenied(_ notification: Notification)
  
  func authorizationSharingAuthorized(_ notification: Notification)
  
  func registerHealthKitAuthorizationObserver()
  
  func unregisterHealthKitAuthorizationObserver()
}

extension HealthKitAuthorizationObserver where Self: UIViewController {
  func authorizationNotDetermined(_ notification: Notification) {
    print("not determined")
  }
  
  func authorizationSharingDenied(_ notification: Notification) {
    print("denied")
  }
  
  func registerHealthKitAuthorizationObserver() {
    NotificationCenter.default.addObserver(
      forName: .healthKitAuthorizationNotDetermined,
      object: nil,
      queue: nil) { [weak self] notification in
        self?.authorizationNotDetermined(notification)
    }
    NotificationCenter.default.addObserver(
      forName: .healthKitAuthorizationSharingDenied,
      object: nil,
      queue: nil) { [weak self] notification in
        self?.authorizationSharingDenied(notification)
    }
    NotificationCenter.default.addObserver(
      forName: .healthKitAuthorizationSharingAuthorized,
      object: nil,
      queue: nil) { [weak self] notification in
        self?.authorizationSharingAuthorized(notification)
    }
  }
  
  func unregisterHealthKitAuthorizationObserver() {
    NotificationCenter.default.removeObserver(
      self,
      name: .healthKitAuthorizationNotDetermined,
      object: nil)
    NotificationCenter.default.removeObserver(
      self,
      name: .healthKitAuthorizationSharingDenied,
      object: nil)
    NotificationCenter.default.removeObserver(
      self,
      name: .healthKitAuthorizationSharingAuthorized,
      object: nil)
  }
}
