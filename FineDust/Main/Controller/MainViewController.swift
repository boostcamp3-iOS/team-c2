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
  
  @IBOutlet weak var distanceLabel: UILabel!
  @IBOutlet weak var stepLabel: UILabel!
  
  // MARK: - Properties
  
  weak var delegate: OpenHealthDelegate?
  fileprivate var healthKitManager = HealthKitManager()
  
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
  }
}

// MARK: - Functions

extension MainViewController {
  private func setup() {
    delegate = FineDustHK.shared
  }
  
  private func putHealthKitValue() {
    healthKitManager.returnDistanceValue { value in
      DispatchQueue.main.async {
        self.distanceLabel.text = String(format: "%.1f", value.kilometer) + " km"
      }
    }
    healthKitManager.returnStepCountValue { value in
      DispatchQueue.main.async {
        self.stepLabel.text = "\(value.int) 걸음"
      }
    }
  }
}
