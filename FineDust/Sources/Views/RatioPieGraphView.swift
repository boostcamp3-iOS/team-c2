//
//  RatioPieGraphView.swift
//  FineDust
//
//  Created by Presto on 20/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

final class RatioPieGraphView: UIView {
  
  private enum Layer {
    
    static let lineWidth: CGFloat = 10.0
  }
  
  @IBOutlet private weak var percentLabel: UILabel!
  
  private var ratio: Double = 0
  
  private var endAngle: Double = 0
  
  func setup(ratio: Double, endAngle: Double) {
    self.ratio = ratio
    self.endAngle = endAngle
    reloadGraphView()
  }
}

// MARK: - Implement GraphDrawable

extension RatioPieGraphView: GraphDrawable {
  
  func deinitializeSubviews() {
    layer.sublayers?.forEach { $0.removeFromSuperlayer() }
  }
  
  func drawGraph() {
    addCircleLayers()
  }
  
  func setLabels() {
    let percent = Int(ratio * 100)
    percentLabel.text = "\(percent)%"
    addSubview(percentLabel) { $0.center.equalTo(snp.center) }
  }
}

// MARK: - Private Method

private extension RatioPieGraphView {
  
  func addCircleLayers() {
    layer.addSublayer(makeEntireShapeLayer())
    layer.addSublayer(makePortionShapeLayer())
  }
  
  func makeEntireShapeLayer() -> CAShapeLayer {
    let shapeLayer = makeCircleLayer(fillColor: .clear,
                                     strokeColor: Asset.graph1.color)
    return shapeLayer
  }
  
  func makePortionShapeLayer() -> CAShapeLayer {
    let shapeLayer = makeCircleLayer(fillColor: .clear,
                                     strokeColor: Asset.graphToday.color,
                                     strokeEnd: CGFloat(ratio),
                                     ratio: CGFloat(ratio))
    let animation = CABasicAnimation(keyPath: "strokeEnd").then {
      $0.fromValue = 0
      $0.toValue = CGFloat(ratio)
      $0.duration = 1
    }
    shapeLayer.add(animation, forKey: nil)
    return shapeLayer
  }
  
  func makeCircleLayer(fillColor: UIColor,
                       strokeColor: UIColor,
                       strokeEnd: CGFloat = 1,
                       ratio: CGFloat = 1) -> CAShapeLayer {
    let graphViewHeight = bounds.width * 0.8
    let path = UIBezierPath(arcCenter: .init(x: bounds.width / 2,
                                             y: bounds.height / 2),
                            radius: graphViewHeight / 2,
                            startAngle: -.pi / 2,
                            endAngle: .pi * 3 / 2,
                            clockwise: true)
    let shapeLayer = CAShapeLayer().then {
      $0.lineWidth = Layer.lineWidth
      $0.fillColor = fillColor.cgColor
      $0.strokeColor = strokeColor.cgColor
      $0.strokeEnd = ratio
      $0.path = path.cgPath
    }
    return shapeLayer
  }
}
