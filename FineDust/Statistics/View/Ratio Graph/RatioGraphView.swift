//
//  RatioGraphView.swift
//  FineDust
//
//  Created by Presto on 22/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

/// 비율 그래프 뷰
final class RatioGraphView: UIView {
  
  /// 비율 관련 작업을 위한 계산 프로퍼티
  var ratio: CGFloat {
    get {
      return _ratio
    }
    set {
      _ratio = newValue
      // 원 그래프 비율 변경하는 코드 추가
    }
  }
  
  /// 비율을 저장하는 private 프로퍼티
  private var _ratio: CGFloat = 0.0
  
  /// 배경 뷰 높이
  private var backgroundViewHeight: CGFloat {
    return backgroundView.bounds.height - 20
  }
  
  // MARK: IBOutlet
  
  /// 배경 뷰
  @IBOutlet private weak var backgroundView: UIView!
  
  // MARK: View
  
  /// 원 그래프의 전체 비율 부분 뷰
  private lazy var entireSectionView: UIView = {
    let view = UIView(
      frame: CGRect(
        x: 0,
        y: 0,
        width: backgroundViewHeight,
        height: backgroundViewHeight
      )
    )
    backgroundView.addSubview(view)
    return view
  }()
  
  /// 원 그래프의 일부 비율 부분 뷰
  private lazy var portionSectionView: UIView = {
    let view = UIView(
      frame: CGRect(
        x: 0,
        y: 0,
        width: backgroundViewHeight,
        height: backgroundViewHeight
      )
    )
    backgroundView.addSubview(view)
    return view
  }()
  
  // MARK: Life Cycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    drawEntireSectionView()
    drawPortionSectionView()
  }
  
  // MARK: Method
  
  /// 전체 비율 부분 뷰 그리기
  private func drawEntireSectionView() {
    entireSectionView.backgroundColor = .lightGray
    entireSectionView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      entireSectionView.height.equal(toConstant: backgroundViewHeight),
      entireSectionView.width.equal(toConstant: backgroundViewHeight),
      entireSectionView.centerX.equal(to: backgroundView.centerX),
      entireSectionView.centerY.equal(to: backgroundView.centerY)
      ])
    entireSectionView.clipsToBounds = true
    entireSectionView.layer.cornerRadius = backgroundViewHeight / 2
  }
  
  /// 일부 비율 부분 뷰 그리기. `endAngle`이 중요하다.
  private func drawPortionSectionView() {
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
      endAngle: -.pi / 4,
      clockwise: true
    )
    path.close()
    let shapeLayer = CAShapeLayer()
    shapeLayer.path = path.cgPath
    shapeLayer.fillColor = UIColor.black.cgColor
    entireSectionView.layer.addSublayer(shapeLayer)
  }
}
