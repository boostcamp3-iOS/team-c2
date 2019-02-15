//
//  XMLError.swift
//  FineDust
//
//  Created by Presto on 31/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// XML 파싱 에러 정의.
enum XMLError: Error {
  
  case implementationIsMissing(String)
  
  case nodeIsInvalid(XMLIndexer)
  
  case nodeHasNoValue
  
  case typeConversionFailed(String, XMLElement)
  
  case attributeDoesNotExist(XMLElement, String)
  
  case attributeDeserializationFailed(String, XMLAttribute)
  
  case `default`
}

// MARK: - 에러 디스크립션

extension XMLError {
  
  var localizedDescription: String {
    switch self {
    case let .implementationIsMissing(method):
      print("XML 구현 오류", method)
    case let .nodeIsInvalid(node):
      print("노드가 유효하지 않음", node)
    case .nodeHasNoValue:
      print("노드에 값이 없음")
    case let .typeConversionFailed(type, node):
      print("타입 변환 실패", type, node)
    case let .attributeDoesNotExist(node, attribute):
      print("애트리뷰트가 존재하지 않음", node, attribute)
    case let .attributeDeserializationFailed(type, attribute):
      print("애트리뷰트 역직렬화 실패", type, attribute)
    case .default:
      print("XML 알 수 없는 오류")
    }
    return "알 수 없는 오류가 발생하였습니다."
  }
}

// MARK: - Equatable 준수

extension XMLError: Equatable {
  
  /// 동등 비교 연산자 구현.
  static func == (lhs: XMLError, rhs: XMLError) -> Bool {
    return lhs.localizedDescription == rhs.localizedDescription
  }
}
