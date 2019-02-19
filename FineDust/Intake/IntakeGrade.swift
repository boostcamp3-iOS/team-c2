//
//  IntakeGrade.swift
//  FineDust
//
//  Created by Presto on 18/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// 흡입량 등급 정의.
enum IntakeGrade: Int {
  
  /// 매우 좋음.
  case veryGood = 1
  
  /// 좋음.
  case good
  
  /// 보통.
  case normal
  
  /// 나쁨.
  case bad
  
  /// 매우 나쁨.
  case veryBad
  
  /// 기타.
  case `default`
  
  /// 흡입량으로 열거형 인스턴스 생성.
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
  
  /// 아이콘 이름 문자열.
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
  
  /// 이미지 이름 문자열.
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
