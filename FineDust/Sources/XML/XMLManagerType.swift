//
//  XMLManagerType.swift
//  FineDust
//
//  Created by Presto on 02/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import SWXMLHash

/// XML 매니저 프로토콜.
protocol XMLManagerType: class {

  // 주어진 데이터를 특정 타입으로 인코딩.
  func decode<T>(_ data: Data, completion: @escaping (T?, Error?) -> Void) where T: XMLParsingType
}
