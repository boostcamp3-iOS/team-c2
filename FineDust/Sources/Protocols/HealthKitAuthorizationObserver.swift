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
  
  func authorizationSharingAuthorized(_ notification: Notification)
  
  func registerHealthKitAuthorizationObserver()
  
  func unregisterHealthKitAuthorizationObserver()
}

extension HealthKitAuthorizationObserver where Self: UIViewController {
  
  func registerHealthKitAuthorizationObserver() {
    NotificationCenter.default
      .addObserver(forName: .healthKitAuthorizationSharingAuthorized,
                   object: nil,
                   queue: nil) { [weak self] notification in
                    self?.authorizationSharingAuthorized(notification)
    }
  }
  
  func unregisterHealthKitAuthorizationObserver() {
    NotificationCenter.default
      .removeObserver(self, name: .healthKitAuthorizationSharingAuthorized, object: nil)
  }
}
