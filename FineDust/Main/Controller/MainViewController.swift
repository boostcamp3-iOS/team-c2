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
  
  weak var healthKitServiceType: HealthKitServiceType?
  
  // MARK: - Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
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
    healthKitServiceType = HealthKitServiceManager.shared
  }
  
  private func updateViewController() {
    healthKitServiceType?.openHealth(self)
    healthKitServiceType?.fetchHealthKitValue(label: stepCountLabel,
                                              quantityTypeIdentifier: .stepCount)
    healthKitServiceType?.fetchHealthKitValue(label: distanceLabel,
                                              quantityTypeIdentifier: .distanceWalkingRunning)
  }
}
