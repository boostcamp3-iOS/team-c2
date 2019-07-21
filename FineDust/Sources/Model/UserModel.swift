//
//  UserModel.swift
//  FineDust
//
//  Created by Presto on 21/07/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import RealmSwift

@objcMembers
final class UserModel: Object {
  
  dynamic var address: String = ""
  
  dynamic var distance: Double = 0
  
  dynamic var grade: Int = 0
  
  dynamic var lastAccessedDate: Date = .init()
  
  dynamic var recentFineDust: Int = 0
  
  dynamic var steps: Int = 0
  
  dynamic var todayFineDust: Int = 0
  
  dynamic var todayUltraFineDust: Int = 0
  
  let weekFineDust: List<Int> = .init()
  
  let weekUltraFineDust: List<Int> = .init()
}
