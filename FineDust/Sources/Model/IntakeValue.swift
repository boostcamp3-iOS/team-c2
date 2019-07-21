//
//  IntakeValue.swift
//  FineDust
//
//  Created by Presto on 21/07/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

struct IntakeValue {
  
  let fineDust: Int
  
  let ultraFineDust: Int
}

extension IntakeValue: ExpressibleByArrayLiteral {
  
  init(arrayLiteral elements: Int...) {
    fineDust = elements[0]
    ultraFineDust = elements[1]
  }
}
