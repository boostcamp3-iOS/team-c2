//
//  RatioGraphView.swift
//  FineDust
//
//  Created by Presto on 22/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

/// 비율 그래프 뷰.
final class RatioGraphView: UIView {
  
  // MARK: Delegate
  
  /// Ratio Graph View Data Source.
  weak var dataSource: RatioGraphViewDataSource?
  
  // MARK: View
  
  /// 파이 그래프가 위치하는 좌측 뷰.
  @IBOutlet private weak var pieGraphView: RatioPieGraphView!
  
  /// 타이틀 레이블.
  @IBOutlet private weak var titleLabel: UILabel!
  
  /// 막대 그래프가 위치하는 우측 뷰.
  private lazy var stickGraphView: RatioStickGraphView! = {
    guard let contentView =
      UIView
        .instantiate(fromXib: RatioStickGraphView.classNameToString) as? RatioStickGraphView
      else { return nil }
    contentView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(contentView)
    NSLayoutConstraint.activate([
      contentView.anchor.top.equal(to: pieGraphView.anchor.top),
      contentView.anchor.leading.equal(to: pieGraphView.anchor.trailing, offset: 16),
      contentView.anchor.bottom.equal(to: anchor.bottom),
      contentView.anchor.trailing.equal(to: anchor.trailing, offset: -16)
      ])
    return contentView
  }()
  
  // MARK: Method
  
  override func awakeFromNib() {
    super.awakeFromNib()
    titleLabel.text = "Weekly rate of inhalation".localized
  }
  
  /// 뷰 전체 설정.
  func setup() {
    let ratio = dataSource?.intakeRatio ?? .leastNonzeroMagnitude
    let endAngle = ratio * 2 * .pi - .pi / 2
    let averageIntake = Int(Double((dataSource?.totalIntake ?? 1)) / 7.0)
    let todayIntake = dataSource?.todayIntake ?? 1
    pieGraphView.setState(ratio: ratio, endAngle: endAngle)
    stickGraphView.setState(average: averageIntake, today: todayIntake)
  }
}
