//
//  XMLManager.swift
//  FineDust
//
//  Created by Presto on 02/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// XML 매니저.
final class XMLManager: XMLManagerType {
  
  let xmlDecoder: XMLDecoderType
  
  init(xmlDecoder: XMLDecoderType = XMLDecoder.shared) {
    self.xmlDecoder = xmlDecoder
  }
  
  func decode<T>(_ data: Data,
                 completion: @escaping (T?, Error?) -> Void) where T: XMLParsingType {
    do {
      let headerResponse: ResponseHeader = try xmlDecoder.parse(data)
      guard headerResponse.statusCode == .success else {
        completion(nil, headerResponse.statusCode.error)
        return
      }
      let response: T = try xmlDecoder.parse(data)
      guard response.statusCode == .success else {
        completion(nil, response.statusCode.error)
        return
      }
      completion(response, nil)
    } catch let error as XMLDeserializationError {
      // 라이브러리에 정의된 에러에 대응하는 XMLError 넘겨줌
      switch error {
      case let .implementationIsMissing(method):
        completion(nil, XMLError.implementationIsMissing(method))
      case let .nodeIsInvalid(node):
        completion(nil, XMLError.nodeIsInvalid(node))
      case .nodeHasNoValue:
        completion(nil, XMLError.nodeHasNoValue)
      case let .typeConversionFailed(type, node):
        completion(nil, XMLError.typeConversionFailed(type, node))
      case let .attributeDoesNotExist(node, attribute):
        completion(nil, XMLError.attributeDoesNotExist(node, attribute))
      case let .attributeDeserializationFailed(type, attribute):
        completion(nil, XMLError.attributeDeserializationFailed(type, attribute))
      }
    } catch {
      // 기타 XMLError 넘겨줌
      completion(nil, XMLError.default)
    }
//    let parsed = xmlDecoder.parse(data)
//    do {
//      let headerResponse: ResponseHeader = try parsed.value()
//      guard headerResponse.statusCode == .success else {
//        completion(nil, headerResponse.statusCode.error)
//        return
//      }
//      let response: T = try parsed.value()
//      guard response.statusCode == .success else {
//        completion(nil, response.statusCode.error)
//        return
//      }
//      completion(response, nil)
//    } catch let error as XMLDeserializationError {
//      // 라이브러리에 정의된 에러에 대응하는 XMLError 넘겨줌
//      switch error {
//      case let .implementationIsMissing(method):
//        completion(nil, XMLError.implementationIsMissing(method))
//      case let .nodeIsInvalid(node):
//        completion(nil, XMLError.nodeIsInvalid(node))
//      case .nodeHasNoValue:
//        completion(nil, XMLError.nodeHasNoValue)
//      case let .typeConversionFailed(type, node):
//        completion(nil, XMLError.typeConversionFailed(type, node))
//      case let .attributeDoesNotExist(node, attribute):
//        completion(nil, XMLError.attributeDoesNotExist(node, attribute))
//      case let .attributeDeserializationFailed(type, attribute):
//        completion(nil, XMLError.attributeDeserializationFailed(type, attribute))
//      }
//    } catch {
//      // 기타 XMLError 넘겨줌
//      completion(nil, XMLError.default)
//    }
  }
}
