//
//  StatisticsDatePickerViewController.swift
//  FineDust
//
//  Created by Presto on 22/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

final class StatisticsDatePickerViewController: UIViewController {
  
  @IBOutlet private weak var datePicker: UIDatePicker! {
    didSet {
      datePicker.maximumDate = Date()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}
