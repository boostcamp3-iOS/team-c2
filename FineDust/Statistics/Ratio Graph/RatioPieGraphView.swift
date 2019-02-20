//
//  RatioPieGraphView.swift
//  FineDust
//
//  Created by Presto on 20/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

/// 비율 그래프의 원 그래프 뷰.
final class RatioPieGraphView: UIView {
  
  // MARK: Layer 관련 상수
  
  enum Layer {
    
    /// 그래프 두께.
    static let lineWidth: CGFloat = 10.0
  }
  
  /// 타이머.
  private var timer: Timer?
  
  // MARK: State
  
  /// 전체에 대한 부분의 비율.
  private var ratio: CGFloat = 0
  
  /// 원 그래프의 끝 각도. 라디안.
  private var endAngle: CGFloat = 0
  
  /// 그래프 뷰 높이.
  private var graphHeight: CGFloat = 0
  
  // MARK: View
  
  /// 퍼센트 레이블.
  private lazy var percentLabel: FDCountingLabel = {
    let label = FDCountingLabel()
    label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
    label.translatesAutoresizingMaskIntoConstraints = false
    addSubview(label)
    NSLayoutConstraint.activate([
      label.anchor.centerX.equal(to: anchor.centerX),
      label.anchor.centerY.equal(to: anchor.centerY)
      ])
    return label
  }()
  
  // MARK: Method
  
  /// 상태값 설정하고 뷰 갱신.
  func setState(ratio: CGFloat, endAngle: CGFloat) {
    self.ratio = ratio
    self.endAngle = endAngle
    reloadGraphView()
  }
}

// MARK: - GraphDrawable 구현

extension RatioPieGraphView: GraphDrawable {
  
  /// 서브뷰 초기화.
  func deinitializeSubviews() {
    timer?.invalidate()
    layer.sublayers?.forEach { $0.removeFromSuperlayer() }
  }
  
  /// 그래프 그리기.
  func drawGraph() {
    let graphViewHeight = bounds.width * 0.8
    let path = UIBezierPath(arcCenter: CGPoint(x: bounds.width / 2,
                                               y: bounds.height / 2),
                            radius: graphViewHeight / 2,
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
  
  func setLabels() {
    let endValue = Int(ratio * 100)
    addSubview(percentLabel)
    percentLabel.countFromZero(to: endValue,
                               unit: .percent,
                               interval: FDCountingLabel.interval(forCounting: Double(endValue)))
  }
}
