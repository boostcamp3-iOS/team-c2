//
//  Hour.swift
//  FineDust
//
//  Created by Presto on 29/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

enum Hour: Int, CaseIterable {
  
  case zero
  
  case one
  
  case two
  
  case three
  
  case four
  
  case five
  
  case six
  
  case seven
  
  case eight
  
  case nine
  
  case ten
  
  case eleven
  
  case twelve
  
  case thirteen
  
  case fourteen
  
  case fifteen
  
  case sixteen
  
  case seventeen
  
  case eighteen
  
  case nineteen
  
  case twenty
  
  case twentyOne
  
  case twentyTwo
  
  case twentyThree
  
  case `default`
}

// MARK: - Implement Comparable

extension Hour: Comparable {
  
  static func < (lhs: Hour, rhs: Hour) -> Bool {
    return lhs.rawValue < rhs.rawValue
  }
  
  static func == (lhs: Hour, rhs: Hour) -> Bool {
    return lhs.rawValue == rhs.rawValue
  }
}
