//
//  ResponseHeader.swift
//  FineDust
//
//  Created by Presto on 11/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import SWXMLHash

struct ResponseHeader: XMLParsingType {
  
  let code: Int
  
  let message: String
  
  static func deserialize(_ node: XMLIndexer) throws -> ResponseHeader {
    let headerNode = node["response"]["header"]
    return try .init(code: headerNode["resultCode"].value(),
                     message: headerNode["resultMsg"].value())
  }
  
  var statusCode: DustAPIResultCode {
    return DustAPIResultCode(rawValue: code) ?? .default
  }
}
