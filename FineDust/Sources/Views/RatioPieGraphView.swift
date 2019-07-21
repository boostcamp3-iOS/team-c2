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
  
  /// 레이어 관련 상수 정의.
  private enum Layer {
    
    /// 그래프 두께.
    static let lineWidth: CGFloat = 10.0
  }
  
  // MARK: View
  
  /// 퍼센트 레이블.
  private lazy var percentLabel: UILabel = {
    let label = UILabel().then {
      $0.font = .systemFont(ofSize: 20, weight: .semibold)
    }
    addSubview(label) { $0.center.equalTo(snp.center) }
    return label
  }()
  
  // MARK: Property
  
  /// 타이머.
  private var timer: Timer?
  
  /// 전체에 대한 부분의 비율.
  private var ratio: Double = 0
  
  /// 원 그래프의 끝 각도. 라디안.
  private var endAngle: Double = 0
  
  /// 그래프 뷰 높이.
  private var graphHeight: Double = 0
  
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
    percentLabel.text = "\(endValue)%"
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
    let shapeLayer = CAShapeLayer().then {
      $0.path = path.cgPath
      $0.lineWidth = Layer.lineWidth
      $0.fillColor = fillColor.cgColor
      $0.strokeColor = strokeColor.cgColor
      $0.strokeEnd = ratio
    }
    return shapeLayer
  }
  
  /// 레이어에 애니메이션 추가하기.
  func addAnimation(to shapeLayer: CAShapeLayer, ratio: CGFloat) {
    let animation = CABasicAnimation(keyPath: "strokeEnd").then {
      $0.fromValue = 0
      $0.toValue = ratio
      $0.duration = 1
    }
    shapeLayer.add(animation, forKey: animation.keyPath)
  }
}
