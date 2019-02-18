//
//  AppIconManager.swift
//  FineDust
//
//  Created by Presto on 18/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation
import UIKit

/// 앱 아이콘 매니저 프로토콜.
protocol AppIconManagerType: class {
  
  /// 앱 아이콘 변경.
  func changeAppIcon(to imageName: String?)
}

/// 앱 아이콘 매니저.
final class AppIconManager: AppIconManagerType {
  
  static let shared = AppIconManager()
  
  private init() { }
  
  func changeAppIcon(to imageName: String?) {
    guard UIApplication.shared.supportsAlternateIcons else { return }
    UIApplication.shared.setAlternateIconName(imageName) { error in
      if let error = error {
        print(error.localizedDescription)
      }
    }
  }
}
