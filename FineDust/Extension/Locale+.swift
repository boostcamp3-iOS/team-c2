//
//  Locale+.swift
//  FineDust
//
//  Created by Presto on 08/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

extension Locale {
  
  /// 대한민국 로케일.
  static let korea = Locale(identifier: "ko_KR")
  
  static var preferredLocale: Locale {
    let deviceLanguage = Locale.current.languageCode
    return deviceLanguage == "ko" ? .korea : .current
  }
}
