//
//  FineDustResponse.swift
//  FineDust
//
//  Created by Presto on 23/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import SWXMLHash

/// 미세먼지 정보 응답 객체.
struct DustResponse: XMLParsingType {
 
  /// 미세먼지 API 결과 객체.
  struct Result: XMLIndexerDeserializable {
    
    /// 상태 코드.
    let code: Int
    
    /// 상태 메세지;.
    let message: String
    
    static func deserialize(_ node: XMLIndexer) throws -> Result {
      return try Result(code: node["resultCode"].value(),
                        message: node["resultMsg"].value())
    }
  }
  
  /// 미세먼지 정보 응답 관련 정보.
  struct Item: XMLIndexerDeserializable {
    
    /// 관측 시간. `2019-01-29 16:00`. Format: `yyyy-MM-dd HH:mm`
    let dataTime: String
    
    let fineDustValueString: String
    
    let fineDustGradeString: String
    
    let ultrafineDustValueString: String
    
    let ultrafineDustGradeString: String
    
    /// 미세먼지 현재 농도.
    var fineDustValue: Int {
      return Int(fineDustValueString) ?? 0
    }
    
    /// 미세먼지 현재 등급.
    var fineDustGrade: Int {
      return Int(fineDustGradeString) ?? 0
    }
    
    /// 초미세먼지 현재 농도.
    var ultrafineDustValue: Int {
      return Int(ultrafineDustValueString) ?? 0
    }

    /// 초미세먼지 현재 등급.
    var ultrafineDustGrade: Int {
      return Int(ultrafineDustGradeString) ?? 0
    }
    
    static func deserialize(_ node: XMLIndexer) throws -> Item {
      return try Item(dataTime: node["dataTime"].value(),
                      fineDustValueString: node["pm10Value"].value(),
                      fineDustGradeString: node["pm10Grade"].value(),
                      ultrafineDustValueString: node["pm25Value"].value(),
                      ultrafineDustGradeString: node["pm25Grade"].value())
    }
  }
  
  /// 결과 객체.
  let result: Result
  
  /// 총 정보량.
  let totalCount: Int
  
  /// 관측소 관련 정보들.
  let items: [Item]
  
  static func deserialize(_ node: XMLIndexer) throws -> DustResponse {
    return try DustResponse(result: node["response"]["header"].value(),
                            totalCount: node["response"]["body"]["totalCount"].value(),
                            items: node["response"]["body"]["items"]["item"].value())
  }
  
  /// 미세먼지 API 상태 코드.
  var statusCode: DustStatusCode {
    return DustStatusCode(rawValue: result.code) ?? .default
  }
}
