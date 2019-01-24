//
//  ValueGraphViewDelegate.swift
//  FineDust
//
//  Created by Presto on 24/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

/// Value Graph View Delegate
protocol ValueGraphViewDelegate: class {

  var day: Date { get }
  
  var values: [CGFloat] { get }
  
  func valueGraphView(_ view: ValueGraphView, didTapDateButton button: UIButton)
}
