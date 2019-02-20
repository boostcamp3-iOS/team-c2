//
//  FDCountingLabel.swift
//  FineDust
//
//  Created by Presto on 17/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import UIKit

/// 파인더스트 카운팅 레이블.
final class FDCountingLabel: UILabel {
  
  /// 타이머.
  private var timer: Timer?
  
  // MARK: Initializer
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  /// 값이 없을 때 설정.
  func setNoValue(_ defaultText: String = "-") {
    text = defaultText
  }
  
  /// 0에서부터 지정된 값까지 차오르기.
  func countFromZero(to value: Int, unit: Unit, interval: TimeInterval = 1.0) {
    timer?.invalidate()
    var startValue: Int = 0
    timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] timer in
      self?.text = "\(startValue)\(unit.rawValue)"
      if startValue == value {
        timer.invalidate()
      }
      startValue += 1
    }
    timer?.fire()
  }
  
  /// 시간 내 카운팅을 위한 인터벌 구하기.
  static func interval(forCounting count: Double, inSecond second: Double = 1.0) -> TimeInterval {
    return second / count
  }
}
