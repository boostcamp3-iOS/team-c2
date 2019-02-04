//
//  Intake+.swift
//  FineDust
//
//  Created by Presto on 25/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import CoreData
import Foundation

/// `Intake` Entity Attribute 상수 정리
extension Intake {
  
  /// 날짜 Attribute
  static let date = "date"
  /// 흡입량 Attribute
  static let value = "value"
}

// MARK: - CoreDataIntakeManagerType 준수

extension Intake: CoreDataIntakeManagerType { }
