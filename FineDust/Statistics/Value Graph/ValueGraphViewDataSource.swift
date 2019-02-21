//
//  ValueGraphViewDelegate.swift
//  FineDust
//
//  Created by Presto on 06/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation
import UIKit

/// Value Graph View Data Source.
protocol ValueGraphViewDataSource: class {

  /// 오늘의 전날부터 일주일간의 흡입량.
  var intakes: [Int] { get }
}
