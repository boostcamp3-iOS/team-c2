//
//  ValueGraphView.swift
//  FineDust
//
//  Created by Presto on 22/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

/// 지정 날짜 기준 일주일 그래프 관련 뷰.
final class ValueGraphView: UIView {

  // MARK: Constant
  
  /// 레이어 관련 상수 모음.
  enum Layer {
    
    static let radius: CGFloat = 2.0
    
    /// 경계선 두께.
    static let borderWidth: CGFloat = 1.0
  }
  
  /// 애니메이션 관련 상수 모음.
  enum Animation {
    
    /// 애니메이션 기간.
    static let duration: TimeInterval = 1.0
    
    /// 애니메이션 지연.
    static let delay: TimeInterval = 0.0
    
    /// 용수철 효과 정도.
    static let damping: CGFloat = 0.7
    
    /// 용수철 효과 시작 속도.
    static let springVelocity: CGFloat = 0.5
    
    /// 애니메이션 옵션.
    static let options: UIView.AnimationOptions = [.curveEaseInOut]
  }
  
  // MARK: Delegate
  
  /// Value Graph View Data Source.
  weak var dataSource: ValueGraphViewDataSource?
  
  // MARK: Private Properties
  
  /// 기준 날짜로부터 7일간의 미세먼지 흡입량.
  private var intakeAmounts: [Int] {
    return dataSource?.intakes ?? []
  }
  
  /// 미세먼지 흡입량의 최대값.
  private var maxValue: Int {
    let max = intakeAmounts.max() ?? 1
    return max
  }
  
  /// 흡입량 모음을 최대값에 대한 비율로 산출. `1.0 - (비율)`.
  private var intakeRatios: [Double] {
    return intakeAmounts.map { 1.0 - Double($0) / Double(maxValue) }
      .map { !$0.canBecomeMultiplier ? 0.01 : $0 }
  }
  
  /// 주축 레이블.
  private var axisTexts: [String] {
    return ["\(Int(maxValue))", "\(Int(maxValue / 2))", "0"]
  }
  
  /// 일 텍스트.
  private var dayTexts: [String] {
    let dateFormatter = DateFormatter.day
    var array = [Date](repeating: Date(), count: 7)
    for (index, element) in array.enumerated() {
      array[index] = element.before(days: index)
    }
    var reversed = Array(array.map { dateFormatter.string(from: $0) }.reversed())
    // 마지막 값을 오늘로 바꿈
    reversed.removeLast()
    reversed.append("오늘")
    return reversed
  }
  
  // MARK: IBOutlets
  
  /// 날짜 레이블.
  @IBOutlet private weak var dateLabel: UILabel!

  /// 제목 레이블.
  @IBOutlet private weak var titleLabel: UILabel!
  
  /// 요일 레이블 모음.
  @IBOutlet private var dayLabels: [UILabel]!
  
  /// 그래프 컨테이너 뷰.
  @IBOutlet private weak var graphContainerView: UIView!
  
  /// 그래프 뷰 모음.
  @IBOutlet private var graphViews: [UIView]! {
    didSet {
      for (index, view) in graphViews.enumerated() {
        view.layer.setBorder(radius: Layer.radius)
        view.backgroundColor = graphBackgroundColor(at: index)
      }
    }
  }
  
  /// 단위 레이블 모음.
  @IBOutlet private var unitLabels: [UILabel]!
  
  /// 그래프 높이 제약 모음.
  @IBOutlet private var graphViewHeightConstraints: [NSLayoutConstraint]!
  
  // MARK: Methods
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  /// 뷰 전체 설정.
  func setup() {
    reloadGraphView()
  }
}

// MARK: - GraphDrawable 구현

extension ValueGraphView: GraphDrawable {
  
  func deinitializeSubviews() {
    initializeHeights()
  }
  
  func drawGraph() {
    animateHeights()
  }
  
  func setLabels() {
    setUnitLabels()
    setDayLabelsTitle()
    setDateLabel()
  }
}

// MARK: - Private Method

private extension ValueGraphView {
  
  /// 그래프 뷰 높이 초기화.
  func initializeHeights() {
    for (index, constraint) in graphViewHeightConstraints.enumerated() {
      graphViewHeightConstraints[index] = constraint.changedMultiplier(to: 1.0)
    }
    layoutIfNeeded()
  }
  
  /// 그래프 뷰 높이 제약에 애니메이션 효과 설정.
  func animateHeights() {
    for (index, ratio) in intakeRatios.enumerated() {
      var heightConstraint = graphViewHeightConstraints[index]
      DispatchQueue.main.async {
        UIView.animate(
          withDuration: Animation.duration,
          delay: Animation.delay,
          usingSpringWithDamping: Animation.damping,
          initialSpringVelocity: Animation.springVelocity,
          options: Animation.options,
          animations: { [weak self] in
            heightConstraint = heightConstraint.changedMultiplier(to: CGFloat(ratio))
            self?.layoutIfNeeded()
          },
          completion: nil
        )
      }
    }
  }
  
  /// 주축 레이블 설정.
  func setUnitLabels() {
    zip(unitLabels, axisTexts).forEach { $0.text = $1 }
  }
  
  /// 요일 레이블 텍스트 설정.
  func setDayLabelsTitle() {
    zip(dayLabels, dayTexts).forEach { $0.text = $1 }
  }
  
  /// 날짜 레이블 설정.
  func setDateLabel() {
    dateLabel.text = DateFormatter.localizedDateWithDay.string(from: Date())
  }
  
  /// 그래프 색상 구하기.
  func graphBackgroundColor(at index: Int) -> UIColor? {
    if index == 6 {
      return Asset.graphToday.color
    }
    return index % 2 == 0 ? Asset.graph1.color : Asset.graph2.color
  }
}
