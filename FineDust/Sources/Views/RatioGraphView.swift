//
//  RatioGraphView.swift
//  FineDust
//
//  Created by Presto on 22/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

import SnapKit

final class RatioGraphView: UIView {
  
  weak var dataSource: RatioGraphViewDataSource?
  
  @IBOutlet private weak var titleLabel: UILabel!
  
  @IBOutlet private weak var pieGraphView: RatioPieGraphView!
  
  private lazy var stickGraphView: RatioStickGraphView! = {
    let view = UIView.instantiate(fromType: RatioStickGraphView.self)
    addSubview(view) {
      $0.top.equalTo(pieGraphView.snp.top)
      $0.leading.equalTo(pieGraphView.snp.trailing).offset(16)
      $0.bottom.equalTo(pieGraphView.snp.bottom)
      $0.trailing.equalTo(snp.trailing).offset(16)
    }
    return view
  }()
  
  func setup() {
    let ratio = dataSource?.intakeRatio ?? .leastNonzeroMagnitude
    let endAngle = ratio * 2 * .pi - .pi / 2
    let averageIntake = Int(Double((dataSource?.totalIntake ?? 1)) / 7)
    let todayIntake = dataSource?.todayIntake ?? 1
    pieGraphView.setup(ratio: ratio, endAngle: endAngle)
    stickGraphView.setup(average: averageIntake, today: todayIntake)
  }
}

// MARK: - Implement GraphDrawable

extension RatioGraphView: GraphDrawable { }
