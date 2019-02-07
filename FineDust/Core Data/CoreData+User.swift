//
//  User+.swift
//  FineDust
//
//  Created by Presto on 25/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import CoreData
import Foundation

/// `User` Entity Attribute 상수 정리
extension User {
  
  /// 최근 접속 날짜 Attribute
  static let lastDate = "lastDate"
}

// MARK: - CoreDataUserManagerType 준수

extension User: CoreDataUserManagerType { }
