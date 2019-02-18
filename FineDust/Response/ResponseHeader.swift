//
//  ResponseHeader.swift
//  FineDust
//
//  Created by Presto on 11/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// 미세먼지 API의 Response 관련 부분을 먼저 파싱하기 위한 응답 객체.
struct ResponseHeader: XMLParsingType {
  
  /// 상태 코드.
  let code: Int
  
  /// 상태 메세지.
  let message: String
  
  static func deserialize(_ node: XMLIndexer) throws -> ResponseHeader {
    return try ResponseHeader(code: node["response"]["header"]["resultCode"].value(),
                              message: node["response"]["header"]["resultMsg"].value())
  }
  
  /// 미세먼지 API 상태 코드.
  var statusCode: DustStatusCode {
    return DustStatusCode(rawValue: code) ?? .default
  }
}
