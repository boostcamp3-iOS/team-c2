//
//  RatioGraphView.swift
//  FineDust
//
//  Created by Presto on 22/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

/// Ratio Graph View Data Source Protocol.
protocol RatioGraphViewDataSource: class {
  /// 전체에 대한 부분의 비율.
  var intakeRatio: CGFloat { get }
}

/// 비율 그래프 뷰.
final class RatioGraphView: UIView {
  
  // MARK: Constant
  
  /// 상수 정리.
  enum Constant {
    /// 배경 뷰 높이와 전체 비율 섹션 뷰 높이의 차이.
    static let entireSectionViewHeightDifference: CGFloat = 64.0
    /// 가운데 원형 뷰 반지름의 전체 비율 섹션 뷰 반지름과의 비율.
    static let centerHoleViewRadiusRatio: CGFloat = 1.2
  }
  
  // MARK: Delegate
  
  /// Ratio Graph View Data Source.
  weak var dataSource: RatioGraphViewDataSource?
  
  // MARK: Private Properties
  
  /// 전체에 대한 부분의 비율.
  private var ratio: CGFloat {
    return dataSource?.intakeRatio ?? 0.0
  }
  /// 비율을 각도로 변환.
  private var endAngle: CGFloat {
    return ratio * 2 * .pi - .pi / 2
  }
  /// 배경 뷰 높이.
  private var backgroundViewHeight: CGFloat {
    return backgroundView.bounds.height - Constant.entireSectionViewHeightDifference
  }
  
  // MARK: IBOutlet
  
  /// 배경 뷰.
  @IBOutlet private weak var backgroundView: UIView!
  
  // MARK: View
  
  /// 원 그래프의 전체 비율 부분 뷰.
  private var entireSectionView: UIView!
  /// 가운데 비어 있는 원.
  private var centerHoleView: UIView!
  /// 퍼센트 레이블.
  private var percentLabel: UILabel!
  
  // MARK: Method
  
  /// 뷰 전체 설정.
  func setup() {
    if entireSectionView != nil {
      deinitializeSubviews()
    }
    drawEntireSectionView()
    drawPortionSectionView()
    drawCenterHoleView()
    setPercentLabel()
  }
}

// MARK: - View Drawing

private extension RatioGraphView {
  /// 서브뷰 초기화.
  func deinitializeSubviews() {
    entireSectionView.removeFromSuperview()
    centerHoleView.removeFromSuperview()
    percentLabel.removeFromSuperview()
  }
  /// 전체 비율 뷰 그리기.
  func drawEntireSectionView() {
    entireSectionView = UIView(frame: CGRect(
      x: 0,
      y: 0,
      width: backgroundViewHeight,
      height: backgroundViewHeight
    ))
    backgroundView.addSubview(entireSectionView)
    entireSectionView.backgroundColor = Asset.graph1.color
    entireSectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      entireSectionView.anchor.width.equal(toConstant: backgroundViewHeight),
      entireSectionView.anchor.height.equal(toConstant: backgroundViewHeight),
      entireSectionView.anchor.centerX.equal(to: backgroundView.anchor.centerX),
      entireSectionView.anchor.centerY.equal(to: backgroundView.anchor.centerY)
      ])
    entireSectionView.clipsToBounds = true
    entireSectionView.layer.cornerRadius = backgroundViewHeight / 2
  }
  /// 부분 비율 뷰 그리기.
  func drawPortionSectionView() {
    let path = UIBezierPath()
    path.move(to: entireSectionView.center)
    path.addLine(to: CGPoint(
      x: entireSectionView.frame.width / 2,
      y: entireSectionView.frame.height
    ))
    path.addArc(
      withCenter: entireSectionView.center,
      radius: backgroundViewHeight,
      startAngle: -.pi / 2,
      endAngle: endAngle,
      clockwise: true
    )
    path.close()
    let shapeLayer = CAShapeLayer()
    shapeLayer.path = path.cgPath
    shapeLayer.fillColor = Asset.graphToday.color.cgColor
    shapeLayer.applySketchShadow(color: .black, alpha: 0.5, x: 0, y: 0, blur: 8, spread: 0)
    entireSectionView.layer.addSublayer(shapeLayer)
  }
  /// 가운데 빈 효과 내는 원 그리기.
  func drawCenterHoleView() {
    centerHoleView = UIView()
    centerHoleView.backgroundColor = .white
    backgroundView.addSubview(centerHoleView)
    centerHoleView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      centerHoleView.anchor.width.equal(
        toConstant: backgroundViewHeight / Constant.centerHoleViewRadiusRatio
      ),
      centerHoleView.anchor.height.equal(
        toConstant: backgroundViewHeight / Constant.centerHoleViewRadiusRatio
      ),
      centerHoleView.anchor.centerX.equal(to: backgroundView.anchor.centerX),
      centerHoleView.anchor.centerY.equal(to: backgroundView.anchor.centerY)
      ])
    centerHoleView.clipsToBounds = true
    centerHoleView.layer.cornerRadius
      = backgroundViewHeight / 2 / Constant.centerHoleViewRadiusRatio
  }
  /// 비어 있는 원 안에 퍼센트 레이블 설정하기.
  func setPercentLabel() {
    percentLabel = UILabel()
    percentLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
    percentLabel.text = "\(Int(ratio * 100))%"
    percentLabel.translatesAutoresizingMaskIntoConstraints = false
    centerHoleView.addSubview(percentLabel)
    NSLayoutConstraint.activate([
      percentLabel.anchor.centerX.equal(to: centerHoleView.anchor.centerX),
      percentLabel.anchor.centerY.equal(to: centerHoleView.anchor.centerY)
      ])
  }
}
