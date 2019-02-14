//
//  XMLManager.swift
//  FineDust
//
//  Created by Presto on 02/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// XML 매니저.
final class XMLManager<T>: XMLManagerType where T: XMLParsingType {
  
  let xmlConfig: SWXMLHash

  init(xmlConfig: SWXMLHash = SWXMLHash.config { $0.detectParsingErrors = true }) {
    self.xmlConfig = xmlConfig
  }
  
  func parse(_ data: Data,
             completion: @escaping (XMLParsingType?, Error?) -> Void) {
    let parsed = xmlConfig.parse(data)
    print(parsed)
    do {
      let response: T = try parsed.value()
      // 상태 코드가 00이 아니면 그에 대응하는 에러를 넘겨줌
      guard response.statusCode == .success else {
        completion(nil, response.statusCode.error)
        return
      }
      // 상태 코드가 00이면 파싱된 결과를 넘겨줌
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
  }
}
