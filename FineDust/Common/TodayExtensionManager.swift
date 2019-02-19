//
//  TodayExtensionManager.swift
//  FineDust
//
//  Created by Presto on 19/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

protocol TodayExtensionManagerType: class {
  
  func shareTodayIntakes(fineDust: Int, ultrafineDust: Int)
}

final class TodayExtensionManager: TodayExtensionManagerType {
  
  static let shared = TodayExtensionManager()
  
  private init() { }
  
  func shareTodayIntakes(fineDust: Int, ultrafineDust: Int) {
    if let userDefaults = UserDefaults(suiteName: "group.kr.co.boostcamp3rd.FineDust") {
      userDefaults.set(fineDust, forKey: "fineDustIntake")
      userDefaults.set(ultrafineDust, forKey: "ultrafineDustIntake")
      userDefaults.synchronize()
    }
  }
}
