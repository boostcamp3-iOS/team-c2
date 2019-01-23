//
//  NSObject+.swift
//  FineDust
//
//  Created by Presto on 21/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

extension NSObject {
  var classNameToString: String {
    return NSStringFromClass(type(of: self))
  }
  
  static var classNameToString: String {
    return NSStringFromClass(self).components(separatedBy: ".").last ?? ""
  }
}
