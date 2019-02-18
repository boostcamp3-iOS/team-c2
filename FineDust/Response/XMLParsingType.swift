//
//  XMLParsingType.swift
//  FineDust
//
//  Created by Presto on 02/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// XML 파싱이 가능한 타입.
protocol XMLParsingType: XMLIndexerDeserializable {
  
  /// 상태 코드.
  var statusCode: DustStatusCode { get }
}
