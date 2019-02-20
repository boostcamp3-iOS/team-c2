//
//  CoreDataError.swift
//  FineDust
//
//  Created by Presto on 19/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

enum CoreDataError: ServiceErrorType {
  
  case noUser
  
  var localizedDescription: String {
    switch self {
    case .noUser:
      return "등록된 사용자가 없습니다."
    }
  }
}
