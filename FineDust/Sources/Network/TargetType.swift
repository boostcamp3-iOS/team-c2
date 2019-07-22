//
//  Target.swift
//  FineDust
//
//  Created by Presto on 22/07/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import enum Alamofire.HTTPMethod
import struct Alamofire.HTTPHeaders

protocol TargetType {
  
  var path: String { get }
  
  var method: HTTPMethod { get }
  
  var headers: HTTPHeaders { get }
}
