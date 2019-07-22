//
//  FineDustInfo.swift
//  FineDust
//
//  Created by Presto on 25/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

final class SharedInfo {
  
  static let shared = SharedInfo()
  
  private init() { }
  
  var x: Double = 0
  
  var y: Double = 0
  
  var address: String = ""
  
  var observatory: String = ""
}
