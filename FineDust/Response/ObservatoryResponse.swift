//
//  ObservatoryResponseXML.swift
//  FineDust
//
//  Created by Presto on 29/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// 관측소 응답 객체.
struct ObservatoryResponse: XMLParsingType {
  
  /// 미세먼지 API 결과 객체.
  struct Result: XMLIndexerDeserializable {
    
    /// 상태 코드.
    let code: Int
    
    /// 상태 메세지.
    let message: String
    
    static func deserialize(_ node: XMLIndexer) throws -> Result {
      return try Result(code: node["resultCode"].value(),
                        message: node["resultMsg"].value())
    }
  }
  
  /// 관측소 응답 관련 정보.
  struct Item: XMLIndexerDeserializable {
    
    /// 관측소 주소.
    let address: String
    
    /// 관측소 이름.
    let observatory: String
    
    /// 현재 위치로부터 관측소까지의 거리.
    let distance: Double
    
    static func deserialize(_ node: XMLIndexer) throws -> Item {
      return try Item(address: node["addr"].value(),
                      observatory: node["stationName"].value(),
                      distance: node["tm"].value())
    }
  }

  /// 결과 객체.
  let result: Result
  
  /// 총 정보량.
  let totalCount: Int
  
  /// 관측소 관련 정보들.
  let items: [Item]
  
  static func deserialize(_ node: XMLIndexer) throws -> ObservatoryResponse {
    return try ObservatoryResponse(result: node["response"]["header"].value(),
                                   totalCount: node["response"]["body"]["totalCount"].value(),
                                   items: node["response"]["body"]["items"]["item"].value())
  }
  
  /// 관측소.
  var observatory: String? {
    return items.first?.observatory
  }
  
  /// 미세먼지 API 상태 코드.
  var statusCode: DustStatusCode {
    return DustStatusCode(rawValue: result.code) ?? .success
  }
}
