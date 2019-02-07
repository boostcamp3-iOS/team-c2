//
//  ValueGraphViewDelegate.swift
//  FineDust
//
//  Created by Presto on 06/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation
import UIKit

/// Value Graph View Delegate.
protocol ValueGraphViewDelegate: class {
  
  /// DatePicker의 Done 버튼을 눌렀을 때의 동작 정의.
  func valueGraphView(_ valueGraphView: ValueGraphView,
                      didTapDoneButton button: UIBarButtonItem,
                      in datePicker: UIDatePicker)
  
  /// 기준 날짜.
  var referenceDate: Date { get }
  
  /// 기준 날짜로부터 7일간의 미세먼지 흡입량.
  var intakeAmounts: [CGFloat] { get }
}
