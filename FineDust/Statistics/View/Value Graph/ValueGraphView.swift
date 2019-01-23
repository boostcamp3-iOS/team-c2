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
  
  // MARK: delegate
  
  weak var delegate: ValueGraphViewDelegate?
  
  // MARK: Property
  
  /// 비율 모음
  var ratios: [CGFloat] = []
  
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
      graphViews.forEach { $0.layer.setBorder(color: .black, width: Layer.borderWidth) }
    }
  }

  /// 그래프 높이 제약 모음
  @IBOutlet var graphViewHeightConstraints: [NSLayoutConstraint]! {
    didSet {
      for (index, constraint) in graphViewHeightConstraints.enumerated() {
        graphViewHeightConstraints[index] = constraint.changeMultiplier(to: 0.5)
      }
    }
  }
  
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
  private func animateHeights() {
    
  }
}
