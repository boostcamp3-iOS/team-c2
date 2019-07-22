//
//  Grade.swift
//  FineDust
//
//  Created by Presto on 23/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

enum DustGrade: Int {
  
  case good = 1
  
  case normal
  
  case bad
  
  case veryBad
  
  case `default`
}

extension DustGrade: CustomStringConvertible {
  
  var description: String {
    switch self {
    case .good:
      return "좋음"
    case .normal:
      return "보통"
    case .bad:
      return "나쁨"
    case .veryBad:
      return "매우 나쁨"
    case .default:
      return "알 수 없음"
    }
  }
}
