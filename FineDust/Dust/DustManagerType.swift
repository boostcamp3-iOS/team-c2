//
//  API+FineDust.swift
//  FineDust
//
//  Created by Presto on 21/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// Dust Manager 기반 프로토콜.
protocol DustManagerType {
  
  var baseURL: String { get }
  
  var serviceKey: String { get }
  
  var networkManager: NetworkManagerType { get }
}

// MARK: - DustManagerType 프로토콜 초기 구현

extension DustManagerType {
  
  var baseURL: String {
    return "http://openapi.airkorea.or.kr/openapi/services/rest"
  }
  
  var serviceKey: String {
    return """
    BfJjA4%2BuaBHhfAzyF2Ni6xoVDaf%2FhsZylifmFKdW3kyaZECH6c2Lua05fV%2F%2BYgbzPBaSl0YLZwI%2BW%2FK2xzO7sw%3D%3D
    """
  }
}
