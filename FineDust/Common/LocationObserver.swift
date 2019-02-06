//
//  LocationObserver.swift
//  FineDust
//
//  Created by Presto on 06/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation
import UIKit

protocol LocationObserver: class {
  
  func handleIfSuccess(_ notification: Notification)
  
  func handleIfFail(_ notification: Notification)
  
  func registerLocationObserver()
  
  func unregisterLocationObserver()
}

extension LocationObserver where Self: UIViewController {
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
  }
  
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
  }
}
