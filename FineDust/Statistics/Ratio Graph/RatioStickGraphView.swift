//
//  RatioStickGraphView.swift
//  FineDust
//
//  Created by Presto on 20/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

/// 비율 그래프의 막대 그래프 뷰.
final class RatioStickGraphView: UIView {
  
  enum Layer {
    
    /// 그래프 모서리.
    static let radius: CGFloat = 2.0
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
  
  /// 일주일 평균 흡입량.
  private var averageIntake: Int = 0
  
  /// 오늘의 흡입량.
  private var todayIntake: Int = 0
  
  /// 평균 흡입량 레이블.
  @IBOutlet private weak var averageIntakeLabel: FDCountingLabel!
  
  /// 오늘의 흡입량 레이블.
  @IBOutlet private weak var todayIntakeLabel: FDCountingLabel!
  
  /// 평균 흡입량 그래프 뷰.
  @IBOutlet private weak var averageIntakeGraphView: UIView! {
    didSet {
      averageIntakeGraphView.layer.setBorder(radius: Layer.radius)
    }
  }
  
  /// 오늘의 흡입량 그래프 뷰.
  @IBOutlet private weak var todayIntakeGraphView: UIView! {
    didSet {
      todayIntakeGraphView.layer.setBorder(radius: Layer.radius)
    }
  }
  
  /// 평균 흡입량 뷰 높이 제약.
  @IBOutlet private weak var averageIntakeGraphViewHeightConstraint: NSLayoutConstraint!
  
  /// 오늘의 흡입량 뷰 높이 제약.
  @IBOutlet private weak var todayIntakeGraphViewHeightConstraint: NSLayoutConstraint!
  
  /// 퍼센트 레이블.
  @IBOutlet private weak var percentLabel: FDCountingLabel!
  
  /// 상태 설정하고 뷰 갱신.
  func setState(average: Int, today: Int) {
    averageIntake = average
    todayIntake = today
    reloadGraphView()
  }
}

// MARK: - GraphDrawable 구현

extension RatioStickGraphView: GraphDrawable {
  
  /// 서브뷰 초기화.
  func deinitializeSubviews() {
    averageIntakeGraphViewHeightConstraint
      = averageIntakeGraphViewHeightConstraint.changedMultiplier(to: 0.01)
    todayIntakeGraphViewHeightConstraint
      = todayIntakeGraphViewHeightConstraint.changedMultiplier(to: 0.01)
    layoutIfNeeded()
  }
  
  /// 그래프 그리기.
  func drawGraph() {
    let averageIntakeTempMultiplier = averageIntake >= todayIntake
      ? 1 : CGFloat(averageIntake) / CGFloat(todayIntake)
    let todayIntakeTempMultiplier = averageIntake >= todayIntake
      ? CGFloat(todayIntake) / CGFloat(averageIntake) : 1
    let averageIntakeMultiplier
      = !averageIntakeTempMultiplier.canBecomeMultiplier
        ? 0.01 : averageIntakeTempMultiplier
    let todayIntakeMultiplier
      = !todayIntakeTempMultiplier.canBecomeMultiplier
        ? 0.01 : todayIntakeTempMultiplier
    UIView.animate(
      withDuration: Animation.duration,
      delay: Animation.delay,
      usingSpringWithDamping: Animation.damping,
      initialSpringVelocity: Animation.springVelocity,
      options: Animation.options,
      animations: { [weak self] in
        self?.averageIntakeGraphViewHeightConstraint
          = self?.averageIntakeGraphViewHeightConstraint
            .changedMultiplier(to: averageIntakeMultiplier)
        self?.todayIntakeGraphViewHeightConstraint
          = self?.todayIntakeGraphViewHeightConstraint
            .changedMultiplier(to: todayIntakeMultiplier)
        self?.layoutIfNeeded()
      },
      completion: nil
    )
  }
  
  /// 레이블 설정하기.
  func setLabels() {
    let tempRatio = Double(todayIntake) / Double(averageIntake) * 100
    let ratio = !tempRatio.canBecomeMultiplier ? 0 : tempRatio
    percentLabel.countFromZero(to: Int(ratio),
                               unit: .percent,
                               interval: FDCountingLabel.interval(forCounting: ratio))
    averageIntakeLabel.countFromZero(to: averageIntake,
                                     unit: .none,
                                     interval: FDCountingLabel
                                      .interval(forCounting: Double(averageIntake)))
    todayIntakeLabel.countFromZero(to: todayIntake,
                                   unit: .none,
                                   interval: FDCountingLabel
                                    .interval(forCounting: Double(todayIntake)))
  }
}
