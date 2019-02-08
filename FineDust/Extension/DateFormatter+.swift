//
//  DateFormatter+.swift
//  FineDust
//
//  Created by Presto on 08/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

extension DateFormatter {
  
  /// 날짜 및 시간 데이트 포매터. `yyyy-MM-dd HH:mm`
  ///
  /// `2019-01-01 12:00`
  static let dateAndTime: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale.korea
    formatter.dateFormat = "yyyy-MM-dd HH:mm"
    return formatter
  }()
  
  /// 요일을 포함하여 로케일에 맞게 로컬라이징된 데이트 포매터. `yyyy년 M월 d일 EEEE`
  ///
  /// `2019년 1월 1일 일요일`
  static func localizedDateWithDay(locale: Locale) -> DateFormatter {
    let formatter = DateFormatter()
    formatter.locale = locale
    formatter.dateStyle = .full
    formatter.timeStyle = .none
    return formatter
  }
  
  /// 날짜 데이트 포매터. `yyyy-MM-dd`
  ///
  /// `2019-01-01`
  static let date: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale.korea
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
  }()
  
  /// 시간 데이트 포매터. `HH`
  ///
  /// `12`
  static let hour: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale.korea
    formatter.dateFormat = "HH"
    return formatter
  }()
}
