//
//  DateFormatter+.swift
//  FineDust
//
//  Created by Presto on 08/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

extension DateFormatter {
  
  /// `yyyy-MM-dd HH:mm`
  static let dateTime = DateFormatter().then {
    $0.dateFormat = "yyyy-MM-dd HH:mm"
  }
  
  /// `yyyy년 M월 d일 EEEE`
  static let dateDay = DateFormatter().then {
    $0.dateStyle = .long
    $0.timeStyle = .none
  }
  
  /// `yyyy-MM-dd`
  static let date = DateFormatter().then {
    $0.dateFormat = "yyyy-MM-dd"
  }
  
  /// `HH`
  static let hour = DateFormatter().then {
    $0.dateFormat = "HH"
  }
  
  /// `d`
  static let day = DateFormatter().then {
    $0.dateFormat = "d"
  }
}
