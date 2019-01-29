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
  
  weak var delegate: OpenHealthDelegate?
  weak var healthKitServiceType: HealthKitServiceType?
//  private var healthKitManager = HealthKitManager()
  
  // MARK: - Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    putHealthKitValue()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    delegate?.openHealth(self)
    healthKitServiceType?.fetchHealthKitValue(label: stepCountLabel,
                                              quantityTypeIdentifier: .stepCount)
    healthKitServiceType?.fetchHealthKitValue(label: distanceLabel,
                                              quantityTypeIdentifier: .distanceWalkingRunning)
  }
}

// MARK: - Functions

extension MainViewController {
  private func setup() {
    delegate = FineDustHK.shared
    healthKitServiceType = HealthKitServiceManager.shared
  }
  
  private func putHealthKitValue() {
//    healthKitManager.fetchDistanceValue { value in
//      DispatchQueue.main.async {
//        self.distanceLabel.text = String(format: "%.1f", value.kilometer) + " km"
//      }
//    }
//    healthKitManager.fetchStepCountValue { value in
//      DispatchQueue.main.async {
//        self.stepCountLabel.text = "\(Int(value)) 걸음"
//      }
//    }
  }
}
