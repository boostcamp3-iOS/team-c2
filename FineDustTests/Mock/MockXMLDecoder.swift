//
//  MockXMLDecoder.swift
//  FineDustTests
//
//  Created by Presto on 15/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import Foundation

class MockXMLDecoder: XMLDecoderType {
  
  var error: XMLDeserializationError!
  
  func parse<T>(_ data: Data) throws -> T where T: XMLIndexerDeserializable {
    do {
      return try config.parse(data).value()
    } catch {
      if self.error == nil {
        throw error
      } else {
        throw self.error
      }
    }
  }
}
