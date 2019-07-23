//
//  XMLManager.swift
//  FineDust
//
//  Created by Presto on 02/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import SWXMLHash

final class XMLManager: XMLManagerType {
  
  private let xmlDecoder: XMLDecoderType
  
  init(xmlDecoder: XMLDecoderType = XMLDecoder()) {
    self.xmlDecoder = xmlDecoder
  }
  
  func decode<T>(_ data: Data,
                 completion: @escaping (T?, Error?) -> Void) where T: XMLParsingType {
    do {
      // 먼저 헤더 정보를 파싱하여 미세먼지 에러 정보를 빼냄
      // 성공이 아니면 그에 해당하는 에러를 내려줌
      let headerResponse: DustAPIResponseMetadata = try xmlDecoder.parse(data)
      guard headerResponse.resultCode == .success else {
        completion(headerResponse as? T, headerResponse.resultCode.error)
        return
      }
      // 특정 타입으로 파싱함
      // 성공이 아니면 그에 해당하는 에러를 내려줌
      let response: T = try xmlDecoder.parse(data)
      guard response.resultCode == .success else {
        completion(response, response.resultCode.error)
        return
      }
      // 모두 성공하면 파싱된 데이터를 내려줌
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
      completion(nil, error)
    }
  }
}