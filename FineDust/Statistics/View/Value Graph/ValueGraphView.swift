//
//  ValueGraphView.swift
//  FineDust
//
//  Created by Presto on 22/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

/// ValueGraphView Delegate
protocol ValueGraphViewDelegate: class {
  
  func valueGraphView(_ view: ValueGraphView, didTapDateButton button: UIButton)
}

/// 지정 날짜 기준 일주일 그래프 관련 뷰
final class ValueGraphView: UIView {

  /// 레이어 관련 상수 모음
  enum Layer {
    
    static let borderWidth: CGFloat = 1.0
  }
  
  /// 애니메이션 관련 상수 모음
  enum Animation {
    
    static let duration: TimeInterval = 0.5
    
    static let delay: TimeInterval = 0.0
    
    static let damping: CGFloat = 0.4
    
    static let springVelocity: CGFloat = 0.5
    
    static let option: UIView.AnimationOptions = .curveEaseInOut
  }
  
  // MARK: delegate
  
  weak var delegate: ValueGraphViewDelegate?
  
  // MARK: API
  
  /// 비율 모음
  var ratios: [CGFloat] = [0.8, 0.25, 0.86, 0.18, 0.45, 0.36, 0.74]
  
  // MARK: Common Property
  
  
  
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
  
  // MARK: Life Cycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  // MARK: @objc Method
  
  @objc private func dateButtonDidTap(_ sender: UIButton) {
    delegate?.valueGraphView(self, didTapDateButton: sender)
  }
  
  // MARK: Method
  
  /// 요일 레이블 텍스트 설정
  private func setTitleDayLabels() {
    
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
  
  func initializeHeights() {
    for (index, constraint) in graphViewHeightConstraints.enumerated() {
      graphViewHeightConstraints[index] = constraint.changedMultiplier(to: 1.0)
    }
    layoutIfNeeded()
  }
}

// MARK: - Private Extension

private extension ValueGraphView {
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
