//
//  ValueGraphView.swift
//  FineDust
//
//  Created by Presto on 22/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

final class StickGraphView: UIView {

  private enum Layer {
    
    static let radius: CGFloat = 2.0
    
    static let borderWidth: CGFloat = 1.0
  }
  
  private enum Animation {
    
    static let duration: TimeInterval = 1.0
    
    static let delay: TimeInterval = 0.0
    
    static let damping: CGFloat = 0.7
    
    static let springVelocity: CGFloat = 0.5
    
    static let options: UIView.AnimationOptions = [.curveEaseInOut]
  }
  
  weak var dataSource: ValueGraphViewDataSource?
  
  @IBOutlet private weak var dateLabel: UILabel!
  
  @IBOutlet private weak var titleLabel: UILabel!

  @IBOutlet private var dayLabels: [UILabel]!
  
  @IBOutlet private weak var graphContainerView: UIView!
  
  @IBOutlet private var graphViews: [UIView]! {
    didSet {
      for (index, view) in graphViews.enumerated() {
        view.layer.applyBorder(radius: Layer.radius)
        view.backgroundColor = graphBackgroundColor(at: index)
      }
    }
  }
  
  @IBOutlet private var unitLabels: [UILabel]!
  
  // MARK: Property
  
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
    reversed.append(L10n.today)
    return reversed
  }
  
  // MARK: Methods
  
  /// 뷰 전체 설정.
  func setup() {
    reloadGraphView()
  }
}

// MARK: - GraphDrawable 구현

extension StickGraphView: GraphDrawable {
  
  func deinitializeSubviews() {
    initializeHeights()
  }
  
  func drawGraph() {
    animateHeights()
  }
  
  func setLabels() {
    titleLabel.text = L10n.weeklyInhalationDose
    setUnitLabels()
    setDayLabelsTitle()
    setDateLabel()
  }
}

// MARK: - Private Method

private extension StickGraphView {
  
  /// 그래프 뷰 높이 초기화.
  func initializeHeights() {
    for graphView in graphViews {
      graphView.snp.updateConstraints { $0.height.equalTo(1) }
    }
    layoutIfNeeded()
  }
  
  /// 그래프 뷰 높이 제약에 애니메이션 효과 설정.
  func animateHeights() {
    for (index, ratio) in intakeRatios.enumerated() {
      let graphView = graphViews[index]
      DispatchQueue.main.async {
        UIView.animate(
          withDuration: Animation.duration,
          delay: Animation.delay,
          usingSpringWithDamping: Animation.damping,
          initialSpringVelocity: Animation.springVelocity,
          options: Animation.options,
          animations: { [weak self] in
            graphView.snp.updateConstraints { $0.height.equalTo(ratio) }
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
