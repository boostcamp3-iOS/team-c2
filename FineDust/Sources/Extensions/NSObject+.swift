//
//  NSObject+.swift
//  FineDust
//
//  Created by Presto on 21/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

extension NSObject {
  
  /// 클래스 이름을 문자열로 변환.
  var classNameToString: String {
    return NSStringFromClass(type(of: self)).components(separatedBy: ".").last ?? ""
  }
  
  /// 클래스 이름을 문자열로 변환.
  static var classNameToString: String {
    return NSStringFromClass(self).components(separatedBy: ".").last ?? ""
  }
}
