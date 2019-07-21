//
//  IntakeModel.swift
//  FineDust
//
//  Created by Presto on 21/07/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import RealmSwift

@objcMembers
final class IntakeModel: Object {
 
  dynamic var date: Date = .init()
  
  dynamic var fineDust: Int = 0
  
  dynamic var ultraFineDust: Int = 0
}
