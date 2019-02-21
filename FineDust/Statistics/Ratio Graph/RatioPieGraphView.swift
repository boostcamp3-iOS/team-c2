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
  private var ratio: Double = 0
  
  /// 원 그래프의 끝 각도. 라디안.
  private var endAngle: Double = 0
  
  /// 그래프 뷰 높이.
  private var graphHeight: Double = 0
  
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
  func setState(ratio: Double, endAngle: Double) {
    self.ratio = ratio
    self.endAngle = endAngle
    reloadGraphView()
  }
}

// MARK: - GraphDrawable 구현

extension RatioPieGraphView: GraphDrawable {
  
  func deinitializeSubviews() {
    timer?.invalidate()
    layer.sublayers?.forEach { $0.removeFromSuperlayer() }
  }
  
  func drawGraph() {
    addAnimatedCircleLayers()
  }
  
  func setLabels() {
    let endValue = Int(ratio * 100)
    addSubview(percentLabel)
    percentLabel.countFromZero(to: endValue,
                               unit: .percent,
                               interval: FDCountingLabel.interval(forCounting: Double(endValue)))
  }
}

// MARK: - Private Method

private extension RatioPieGraphView {
  
  /// 애니메이션 효과가 적용된 원형 레이어 추가하기.
  func addAnimatedCircleLayers() {
    formEntireShapeLayer()
    formPortionShapeLayer()
  }
  
  /// 전체 레이어 만들기.
  func formEntireShapeLayer() {
    let shapeLayer = formCircleLayer(fillColor: .clear,
                                     strokeColor: Asset.graph1.color,
                                     strokeEnd: 1,
                                     ratio: 1)
    addAnimation(to: shapeLayer, ratio: 1)
    layer.addSublayer(shapeLayer)
  }
  
  /// 부분 레이어 만들기.
  func formPortionShapeLayer() {
    let shapeLayer = formCircleLayer(fillColor: .clear,
                                     strokeColor: Asset.graphToday.color,
                                     strokeEnd: CGFloat(ratio),
                                     ratio: CGFloat(ratio))
    addAnimation(to: shapeLayer, ratio: CGFloat(ratio))
    layer.addSublayer(shapeLayer)
  }
  
  /// 원형 레이어 만들기.
  func formCircleLayer(fillColor: UIColor,
                       strokeColor: UIColor,
                       strokeEnd: CGFloat,
                       ratio: CGFloat) -> CAShapeLayer {
    let graphViewHeight = bounds.width * 0.8
    let path = UIBezierPath(arcCenter: CGPoint(x: bounds.width / 2,
                                               y: bounds.height / 2),
                            radius: graphViewHeight / 2,
                            startAngle: -.pi / 2,
                            endAngle: .pi * 3 / 2,
                            clockwise: true)
    let shapeLayer = CAShapeLayer()
    shapeLayer.path = path.cgPath
    shapeLayer.lineWidth = Layer.lineWidth
    shapeLayer.fillColor = fillColor.cgColor
    shapeLayer.strokeColor = strokeColor.cgColor
    shapeLayer.strokeEnd = ratio
    return shapeLayer
  }
  
  /// 레이어에 애니메이션 추가하기.
  func addAnimation(to shapeLayer: CAShapeLayer, ratio: CGFloat) {
    let animation = CABasicAnimation(keyPath: "strokeEnd")
    animation.fromValue = 0
    animation.toValue = ratio
    animation.duration = 1
    shapeLayer.add(animation, forKey: animation.keyPath)
  }
}
