//
//  TodayExtensionManager.swift
//  FineDust
//
//  Created by Presto on 19/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// 투데이 익스텐션 매니저 프로토콜.
protocol TodayExtensionManagerType: class {
  
  /// 투데이 익스텐션과 흡입량 정보 공유하기.
  func shareTodayIntakes(_ fineDust: Int, _ ultrafineDust: Int)
}

/// 투데이 익스텐션 매니저.
final class TodayExtensionManager: TodayExtensionManagerType {
  
  /// Singleton Object.
  static let shared = TodayExtensionManager()
  
  private init() { }
  
  func shareTodayIntakes(_ fineDust: Int, _ ultrafineDust: Int) {
    if let userDefaults = UserDefaults(suiteName: "group.kr.co.boostcamp3rd.FineDust") {
      userDefaults.set(fineDust, forKey: "fineDustIntake")
      userDefaults.set(ultrafineDust, forKey: "ultrafineDustIntake")
      userDefaults.synchronize()
    }
  }
}
