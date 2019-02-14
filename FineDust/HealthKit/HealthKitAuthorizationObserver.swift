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
    print("sharing denied")
  }
  
  func authorizationSharingAuthorized(_ notification: Notification) {
    print("sharing authorized")
  }
}
