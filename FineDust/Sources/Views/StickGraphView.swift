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
  
  weak var dataSource: StickGraphViewDataSource?
  
  @IBOutlet private weak var titleLabel: UILabel!
  
  @IBOutlet private weak var dateLabel: UILabel!
  
  @IBOutlet private var unitLabels: [UILabel]!
  
  @IBOutlet private var graphViews: [UIView]!

  @IBOutlet private var dayLabels: [UILabel]!
  
  
  private var intakeAmounts: [Int] {
    return dataSource?.intakes ?? []
  }
  
  private var maxIntakeAmount: Int {
    let max = intakeAmounts.max() ?? 1
    return max
  }
  
  private var intakeRatios: [Double] {
    return intakeAmounts
      .map { 1.0 - Double($0) / Double(maxIntakeAmount) }
      .map { !$0.canBecomeMultiplier ? 0.01 : $0 }
  }
  
  private var axisTexts: [String] {
    return ["\(Int(maxIntakeAmount))", "\(Int(maxIntakeAmount / 2))", "0"]
  }
  
  private var dayTexts: [String] {
    let dateFormatter = DateFormatter.day
    var array = [Date](repeating: .init(), count: 7)
    for (index, element) in array.enumerated() {
      array[index] = element.before(days: index)
    }
    var reversed = Array(array.map { dateFormatter.string(from: $0) }.reversed())
    reversed.removeLast()
    reversed.append("오늘")
    return reversed
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    for (index, view) in graphViews.enumerated() {
      view.layer.applyBorder(radius: Layer.radius)
      view.backgroundColor = graphBackgroundColor(at: index)
    }
  }
  
  func setup() {
    reloadGraphView()
  }
}

// MARK: - Implement GraphDrawable

extension StickGraphView: GraphDrawable {
  
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

private extension StickGraphView {
  
  func initializeHeights() {
    for graphView in graphViews {
      graphView.snp.updateConstraints { $0.height.equalTo(1) }
    }
    layoutIfNeeded()
  }
  
  func animateHeights() {
    for (index, ratio) in intakeRatios.enumerated() {
      UIView.animate(
        withDuration: Animation.duration,
        delay: Animation.delay,
        usingSpringWithDamping: Animation.damping,
        initialSpringVelocity: Animation.springVelocity,
        options: Animation.options,
        animations: { [weak self] in
          self?.graphViews[index].snp.updateConstraints { $0.height.equalTo(ratio) }
          self?.layoutIfNeeded()
        },
        completion: nil
      )
    }
  }
  
  func setUnitLabels() {
    zip(unitLabels, axisTexts).forEach { $0.text = $1 }
  }
  
  func setDayLabelsTitle() {
    zip(dayLabels, dayTexts).forEach { $0.text = $1 }
  }
  
  func setDateLabel() {
    dateLabel.text = DateFormatter.dateDay.string(from: Date())
  }
  
  func graphBackgroundColor(at index: Int) -> UIColor {
    if index == 6 {
      return Asset.graphToday.color
    }
    return index.isMultiple(of: 2) ? Asset.graph1.color : Asset.graph2.color
  }
}
