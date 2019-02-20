//
//  RatioPieGraphView.swift
//  FineDust
//
//  Created by Presto on 20/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

final class RatioPieGraphView: UIView {
  
  enum Layer {
    
    static let lineWidth: CGFloat = 10.0
  }
  
  private var ratio: CGFloat = 0
  
  private var endAngle: CGFloat = 0
  
  private var graphHeight: CGFloat = 0
  
  private lazy var percentLabel: FDCountingLabel = {
    let label = FDCountingLabel()
    label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
    label.translatesAutoresizingMaskIntoConstraints = false
    leftBackgroundView.addSubview(label)
    NSLayoutConstraint.activate([
      label.anchor.centerX.equal(to: leftBackgroundView.anchor.centerX),
      label.anchor.centerY.equal(to: leftBackgroundView.anchor.centerY)
      ])
    return label
  }()
  
  private var timer: Timer?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  func setState() {
    
  }
  
  private func deinitializeSubviews() {
    
  }
  
  private func drawGraph() {
    
  }
  
  private func setPercentLabel() {
    
  }
}
