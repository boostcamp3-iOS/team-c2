//
//  IntakeGrade.swift
//  FineDust
//
//  Created by Presto on 18/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

enum IntakeGrade: Int {
  
  case veryGood = 1
  
  case good
  
  case normal
  
  case bad
  
  case veryBad
  
  case `default`
}

extension IntakeGrade {
  
  init(intake: Int) {
    switch intake {
    case 0..<50:
      self = .veryGood
    case 50..<100:
      self = .good
    case 100..<150:
      self = .normal
    case 150..<200:
      self = .bad
    case 200...:
      self = .veryBad
    default:
      self = .default
    }
  }
  
  var iconName: String {
    switch self {
    case .veryGood:
      return Asset.dustIcon1.name
    case .good:
      return Asset.dustIcon2.name
    case .normal:
      return Asset.dustIcon3.name
    case .bad:
      return Asset.dustIcon4.name
    case .veryBad:
      return Asset.dustIcon5.name
    case .default:
      return ""
    }
  }
  
  var imageName: String {
    switch self {
    case .veryGood:
      return Asset.dust1.name
    case .good:
      return Asset.dust2.name
    case .normal:
      return Asset.dust3.name
    case .bad:
      return Asset.dust4.name
    case .veryBad:
      return Asset.dust5.name
    case .default:
      return ""
    }
  }
}
