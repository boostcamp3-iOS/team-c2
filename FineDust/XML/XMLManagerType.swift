//
//  XMLManagerType.swift
//  FineDust
//
//  Created by Presto on 02/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// XML 매니저 프로토콜.
protocol XMLManagerType: class {

  // 주어진 데이터 파싱.
  func decode<T>(_ data: Data, completion: @escaping (T?, Error?) -> Void) where T: XMLParsingType
}
