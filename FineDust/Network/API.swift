//
//  API.swift
//  FineDust
//
//  Created by Presto on 21/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

protocol APIType { }

/// API 정의.
final class DustManager {
  
  // MARK: Singleton Object
  
  /// API의 싱글톤 객체
  static let shared = DustManager()
  
  // MARK: Private Initializer
  
  private init() { }
  
  // MARK: Property
  
  /// Base URL.
  let baseURL = "http://openapi.airkorea.or.kr/openapi/services/rest"
  /// Service Key.
  let serviceKey = """
  BfJjA4%2BuaBHhfAzyF2Ni6xoVDaf%2FhsZylifmFKdW3kyaZECH6c2Lua05fV%2F%2BYgbzPBaSl0YLZwI%2BW%2FK2xzO7sw%3D%3D
  """
}
