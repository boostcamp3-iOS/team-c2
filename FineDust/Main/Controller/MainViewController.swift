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
  
  weak var healthKitManagerType: HealthKitManagerType?
  
  // MARK: - Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "내먼지".localized
    setup()
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
  private func setup() {
    healthKitManagerType = HealthKitManager.shared
  }
  
  private func updateViewController() {
    var value: Double?
    healthKitManagerType?.fetchStepCount(startDate: Date.start(),
                                         endDate: Date()
    ) {
       value = $0
    }
    
    healthKitManagerType?.fetchDistance(startDate: Date.start(),
                                        endDate: Date()
    ) {
      value = $0
    }
    
//    healthKitServiceType?.openHealth(self)
//    healthKitServiceType?.updateHealthKitLabel(label: stepCountLabel,
//                                               quantityTypeIdentifier: .stepCount)
//    healthKitServiceType?.updateHealthKitLabel(
//      label: distanceLabel,
//      quantityTypeIdentifier: .distanceWalkingRunning)
  }
}
