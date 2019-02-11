//
//  ViewController.swift
//  FineDust
//
//  Created by Presto on 21/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
  
  // MARK: - IBOutlets
  
  @IBOutlet private weak var distanceLabel: UILabel!
  @IBOutlet private weak var stepCountLabel: UILabel!
  @IBOutlet private weak var fineDustLabel: UILabel!
  
  // MARK: - Properties
  
  let healthKitService = HealthKitService(healthKit: HealthKitManager())
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "내먼지".localized
    registerLocationObserver()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    updateViewController()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }
  
  deinit {
    unregisterLocationObserver()
  }
}

// MARK: - LocationObserver

extension MainViewController: LocationObserver {
  func handleIfSuccess(_ notification: Notification) {
    DustInfoService().fetchRecentTimeInfo() { info, _ in
      if let info = info {
        DispatchQueue.main.async {
          self.fineDustLabel.text = "\(info.fineDustValue)µg"
        }
      }
    }
  }
  
  func handleIfFail(_ notification: Notification) {
    
  }
  
  func handleIfAuthorizationDenied(_ notification: Notification) {
    
  }
}

// MARK: - Functions

extension MainViewController {
  
  /// 걸음 수, 걸은 거리 값 업데이트하는 메소드.
  private func updateViewController() {
    // 걸음 수 label에 표시
    healthKitService.fetchTodayStepCount { value, error in
      if let error = error {
        DispatchQueue.main.async {
          self.stepCountLabel.text = "0 걸음"
        }
        print(error)
        return
      }
      if let value = value {
        DispatchQueue.main.async {
          self.stepCountLabel.text = "\(Int(value)) 걸음"
        }
      }
    }
    
    // 걸은 거리 label에 표시
    healthKitService.fetchTodayDistance { value, error in
      if let value = value {
        if let error = error {
          DispatchQueue.main.async {
            self.distanceLabel.text = "0 km"
          }
          print(error)
          return
        }
        DispatchQueue.main.async {
          self.distanceLabel.text = String(format: "%.1f", value.kilometer) + " km"
        }
      }
    }
  }
}
