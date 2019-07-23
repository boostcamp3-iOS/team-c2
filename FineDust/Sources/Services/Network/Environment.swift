//
//  Environment.swift
//  FineDust
//
//  Created by Presto on 22/07/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

enum Environment {
  
  case dustAPI
}

extension Environment {
  
  var baseURL: String {
    switch self {
    case .dustAPI:
      return "http://openapi.airkorea.or.kr/openapi/services/rest"
    }
  }
  
  var serviceKey: String {
    switch self {
    case .dustAPI:
      return """
      BfJjA4%2BuaBHhfAzyF2Ni6xoVDaf%2FhsZylifmFKdW3kyaZECH6c2Lua05fV%2F%2BYgbzPBaSl0YLZwI%2BW%2FK2xzO7sw%3D%3D
      """
    }
  }
}
