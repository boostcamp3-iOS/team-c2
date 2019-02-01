//
//  ViewController.swift
//  FineDust
//
//  Created by Presto on 21/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import CoreLocation
import UIKit

final class MainViewController: UIViewController {
  
  // MARK: - IBOutlets
  
  @IBOutlet private weak var distanceLabel: UILabel!
  @IBOutlet private weak var stepCountLabel: UILabel!
  
  // MARK: - Properties
  
  var healthKitService: HealthKitServiceType?
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "내먼지".localized
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    updateViewController()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }
}

// MARK: - Functions

extension MainViewController {
  
  func updateViewController() {
    var value: Double?
    healthKitService?.fetchStepCount(startDate: Date.start(), endDate: Date()) {
      value = $0
      if let value = value {
        DispatchQueue.main.async {
          self.stepCountLabel.text = "\(value)"
        }
      }
    }
    
    healthKitService?.fetchDistance(startDate: Date.start(), endDate: Date()) {       value = $0
      if let value = value {
        DispatchQueue.main.async {
          self.stepCountLabel.text = "\(value)"
        }
      }
    }
  }
}
