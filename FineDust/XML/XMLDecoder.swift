//
//  XMLDecoder.swift
//  FineDust
//
//  Created by Presto on 14/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

final class XMLDecoder: XMLDecoderType {
  
  static let shared = XMLDecoder()
  
  private init() { }
  
  func parse<T>(_ data: Data) throws -> T where T: XMLIndexerDeserializable {
    return try config.parse(data).value()
  }
}
