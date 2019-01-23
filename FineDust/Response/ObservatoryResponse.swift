//
//  ObservatoryResponse.swift
//  FineDust
//
//  Created by Presto on 22/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// 측정소 정보 조회 응답 객체.
struct ObservatoryResponse: Codable {
  
  struct List: Codable {
    
    /// 관측소 주소
    let address: String
    
    /// 관측소 이름
    let stationName: String
    
    /// 현재 위치에서 관측소까지의 거리. km
    let distance: Double
    
    enum CodingKeys: String, CodingKey {
      
      case address = "addr"
      
      case distance = "tm"
      
      case stationName
    }
  }
  
  let list: [List]
  
  /// 응답 개수
  let totalCount: Int
}
