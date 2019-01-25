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
  
  // MARK: - Properties
  
  weak var delegate: OpenHealthDelegate?
  
  // MARK: - Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
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
}
