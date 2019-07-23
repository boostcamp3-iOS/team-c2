//
//  RatioStickGraphView.swift
//  FineDust
//
//  Created by Presto on 20/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

import SnapKit

final class RatioStickGraphView: UIView {
  
  private enum Layer {
    
    static let radius: CGFloat = 2.0
  }
  
  private enum Animation {
    
    static let duration: TimeInterval = 1.0
    
    static let delay: TimeInterval = 0.0
    
    static let damping: CGFloat = 0.7
    
    static let springVelocity: CGFloat = 0.5
    
    static let options: UIView.AnimationOptions = [.curveEaseInOut]
  }
  
  @IBOutlet private weak var percentLabel: UILabel!
  
  @IBOutlet private weak var averageIntakeLabel: UILabel!
  
  @IBOutlet private weak var todayIntakeLabel: UILabel!
  
  @IBOutlet private weak var averageIntakeGraphView: UIView!
    
  @IBOutlet private weak var todayIntakeGraphView: UIView!
  
  
  @IBOutlet private weak var weeklyAverageLabel: UILabel!
  
  @IBOutlet private weak var todayLabel: UILabel!
  
  private var averageIntake: Int = 0
  
  private var todayIntake: Int = 0
  
  override func awakeFromNib() {
    super.awakeFromNib()
    averageIntakeGraphView.layer.applyBorder(radius: Layer.radius)
    todayIntakeGraphView.layer.applyBorder(radius: Layer.radius)
  }
  
  func setup(average: Int, today: Int) {
    averageIntake = average
    todayIntake = today
    reloadGraphView()
  }
}

// MARK: - Implement GraphDrawable

extension RatioStickGraphView: GraphDrawable {
  
  func deinitializeSubviews() {
    averageIntakeGraphView.snp.updateConstraints { $0.height.equalTo(0.01) }
    todayIntakeGraphView.snp.updateConstraints { $0.height.equalTo(0.01) }
    layoutIfNeeded()
  }
  
  func drawGraph() {
    let averageIntakeTempMultiplier = averageIntake >= todayIntake
      ? 1
      : CGFloat(averageIntake) / CGFloat(todayIntake)
    let todayIntakeTempMultiplier = averageIntake >= todayIntake
      ? CGFloat(todayIntake) / CGFloat(averageIntake)
      : 1
    let averageIntakeMultiplier = !averageIntakeTempMultiplier.canBecomeMultiplier
      ? 0.01
      : averageIntakeTempMultiplier
    let todayIntakeMultiplier = !todayIntakeTempMultiplier.canBecomeMultiplier
      ? 0.01
      : todayIntakeTempMultiplier
    
    UIView.animate(
      withDuration: Animation.duration,
      delay: Animation.delay,
      usingSpringWithDamping: Animation.damping,
      initialSpringVelocity: Animation.springVelocity,
      options: Animation.options,
      animations: { [weak self] in
        self?.averageIntakeGraphView.snp
          .updateConstraints { $0.height.equalTo(averageIntakeMultiplier) }
        self?.todayIntakeGraphView.snp
          .updateConstraints { $0.height.equalTo(todayIntakeMultiplier) }
        self?.layoutIfNeeded()
      },
      completion: nil
    )
  }
  
  func setLabels() {
    let tempRatio = Double(todayIntake) / Double(averageIntake) * 100
    let ratio = !tempRatio.canBecomeMultiplier ? 0 : tempRatio
    percentLabel.text = "\(Int(ratio))%"
    averageIntakeLabel.text = "\(averageIntake)"
    todayIntakeLabel.text = "\(todayIntake)"
  }
}
