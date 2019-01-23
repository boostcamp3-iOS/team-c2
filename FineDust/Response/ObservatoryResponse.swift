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
  
  struct Item: Codable {
    
    let stationName: String
    
    let address: String
    
    let distance: Double
    
    enum CodingKeys: String, CodingKey {
      
      case stationName
      
      case address = "addr"
      
      case distance = "tm"
    }
  }
  
  let numberOfRows: Int
  
  let pageNumber: Int
  
  let totalCount: Int
  
  let items: [Item]
  
  enum CodingKeys: String, CodingKey {
    
    case numberOfRows = "numOfRows"
    
    case pageNumber = "pageNo"
    
    case totalCount, items
  }
}
