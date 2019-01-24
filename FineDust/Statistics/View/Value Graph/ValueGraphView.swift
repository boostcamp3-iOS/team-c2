//
//  ValueGraphView.swift
//  FineDust
//
//  Created by Presto on 22/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

/// 지정 날짜 기준 일주일 그래프 관련 뷰
final class ValueGraphView: UIView {

  /// 레이어 관련 상수 모음
  enum Layer {
    
    static let borderWidth: CGFloat = 1.0
  }
  
  /// 애니메이션 관련 상수 모음
  enum Animation {
    
    static let duration: TimeInterval = 0.3
    
    static let delay: TimeInterval = 0.0
    
    static let damping: CGFloat = 0.7
    
    static let springVelocity: CGFloat = 0.5
    
    static let option: UIView.AnimationOptions = .curveEaseInOut
  }
  
  // MARK: delegate

  weak var delegate: ValueGraphViewDelegate?
  
  // MARK: Private Property
  
  /// 값 모음
  private var values: [CGFloat] {
    return delegate?.values ?? []
  }
  
  /// 최대값
  private var maxValue: CGFloat {
    return (values.max() ?? 0.0) + 1.0
  }
  
  /// 값 모음을 최대값에 대한 비율로 산출. `1 - (비율)`
  private var ratios: [CGFloat] {
    return values.map { 1.0 - $0 / maxValue }
  }
  
  /// 주축 레이블
  private var unitTexts: [String] {
    return ["\(Int(maxValue))", "\(Int(maxValue / 2))", "0"]
  }
  
  // MARK: IBOutlet
  
  /// 제목 레이블
  @IBOutlet private weak var titleLabel: UILabel!
  
  /// 날짜 선택 버튼
  @IBOutlet private weak var dateButton: UIButton! {
    didSet {
      dateButton.addTarget(self, action: #selector(dateButtonDidTap(_:)), for: .touchUpInside)
    }
  }
  
  /// 요일 레이블 모음
  @IBOutlet private var dayLabels: [UILabel]!
  
  /// 그래프 뷰 모음
  @IBOutlet private var graphViews: [UIView]! {
    didSet {
      for (index, view) in graphViews.enumerated() {
        view.layer.setBorder(
          color: .black,
          width: 0,
          radius: 2.0
        )
        view.backgroundColor = graphBackgroundColor(at: index)
      }
    }
  }
  
  /// 단위 레이블 모음
  @IBOutlet var unitLabels: [UILabel]!
  
  /// 그래프 높이 제약 모음
  @IBOutlet var graphViewHeightConstraints: [NSLayoutConstraint]!
  
  // MARK: Method
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func setup() {
    initializeHeights()
    animateHeights()
    setUnitLabels()
    setTitleDayLabels()
  }
  
  @objc private func dateButtonDidTap(_ sender: UIButton) {
    delegate?.valueGraphView(self, didTapDateButton: sender)
  }
}

// MARK: - Private Extension

private extension ValueGraphView {
  /// 그래프 뷰 높이 초기화
  func initializeHeights() {
    for (index, constraint) in graphViewHeightConstraints.enumerated() {
      graphViewHeightConstraints[index] = constraint.changedMultiplier(to: 1.0)
    }
    layoutIfNeeded()
  }
  
  /// 그래프 뷰 높이 제약에 애니메이션 효과 설정
  func animateHeights() {
    for (index, ratio) in ratios.enumerated() {
      let plusTime = DispatchTime.now()
      var heightConstraint = graphViewHeightConstraints[index]
      DispatchQueue.main.asyncAfter(deadline: plusTime) { [weak self] in
        UIView.animate(
          withDuration: Animation.duration,
          delay: Animation.delay,
          usingSpringWithDamping: Animation.damping,
          initialSpringVelocity: Animation.springVelocity,
          options: .curveEaseInOut,
          animations: {
            heightConstraint = heightConstraint.changedMultiplier(to: ratio)
            self?.layoutIfNeeded()
        },
          completion: nil
        )
      }
    }
  }
  
  /// 주축 레이블 설정
  func setUnitLabels() {
    zip(unitLabels, unitTexts).forEach { (label, text) in
      label.text = text
    }
  }
  
  /// 요일 레이블 텍스트 설정
  func setTitleDayLabels() {
    
  }
  
  /// 그래프 색상 설정
  func graphBackgroundColor(at index: Int) -> UIColor? {
    if index == 6 {
      return Asset.graphToday.color
    }
    if index % 2 == 0 {
      return Asset.graph1.color
    } else {
      return Asset.graph2.color
    }
  }
}
