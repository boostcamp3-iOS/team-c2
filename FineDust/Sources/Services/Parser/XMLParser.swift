//
//  XMLParser.swift
//  FineDust
//
//  Created by Presto on 23/07/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import SWXMLHash

final class XMLParser {
  
  private let config = SWXMLHash.config { $0.detectParsingErrors = true }
  
  func decodeData<T>(_ data: Data, to type: T.Type) throws -> T where T: XMLParsingType {
    do {
      let response: T = try config.parse(data).value()
      let resultCode = response.resultCode
    }
  }
}

