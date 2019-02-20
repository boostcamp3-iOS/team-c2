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
  
  private var backgroundViewHeight: CGFloat {
    return bounds.width * 0.8
  }
  
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
  
  func setState(ratio: CGFloat, endAngle: CGFloat) {
    self.ratio = ratio
    self.endAngle = endAngle
    deinitializeSubviews()
    drawGraph()
    setPercentLabel()
  }
  
  private func deinitializeSubviews() {
    timer?.invalidate()
    layer.sublayers?.forEach { $0.removeFromSuperlayer() }
  }
  
  private func drawGraph() {
    let path = UIBezierPath(arcCenter: .init(x: bounds.width / 2,
                                             y: bounds.height / 2),
                            radius: backgroundViewHeight / 2,
                            startAngle: -.pi / 2,
                            endAngle: .pi * 3 / 2,
                            clockwise: true)
    // 전체 레이어
    let entireLayer = CAShapeLayer()
    entireLayer.path = path.cgPath
    entireLayer.lineWidth = Layer.lineWidth
    entireLayer.fillColor = UIColor.clear.cgColor
    entireLayer.strokeColor = Asset.graph1.color.cgColor
    layer.addSublayer(entireLayer)
    // 부분 레이어
    let portionLayer = CAShapeLayer()
    portionLayer.path = path.cgPath
    portionLayer.lineWidth = Layer.lineWidth
    portionLayer.fillColor = UIColor.clear.cgColor
    portionLayer.strokeColor = Asset.graphToday.color.cgColor
    portionLayer.strokeEnd = 0
    layer.addSublayer(portionLayer)
    // 부분 레이어에 애니메이션
    let animation = CABasicAnimation(keyPath: "strokeEnd")
    animation.fromValue = 0
    animation.toValue = ratio
    animation.duration = 1
    portionLayer.strokeEnd = ratio
    portionLayer.add(animation, forKey: animation.keyPath)
  }
  
  private func setPercentLabel() {
    
  }
}
