//
//  XMLDecoderType.swift
//  FineDust
//
//  Created by Presto on 14/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import SWXMLHash

protocol XMLDecoderType: class {
  
  var config: SWXMLHash { get }
  
  func parse<T>(_ data: Data) throws -> T where T: XMLIndexerDeserializable
}

extension XMLDecoderType {
  
  var config: SWXMLHash {
    return SWXMLHash.config { $0.detectParsingErrors = true }
  }
}
