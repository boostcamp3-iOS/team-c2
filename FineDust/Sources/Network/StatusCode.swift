//
//  HTTPStatusCode.swift
//  FineDust
//
//  Created by Presto on 29/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

enum StatusCode: Int {
  
  case success = 200
  
  case `default`
}

extension StatusCode {
  
  var error: HTTPError? {
    switch self {
    case .success:
      return nil
    case .default:
      return .default
    }
  }
}
