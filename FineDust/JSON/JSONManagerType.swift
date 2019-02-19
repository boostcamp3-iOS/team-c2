//
//  JSONManagerType.swift
//  FineDust
//
//  Created by 이재은 on 09/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// JSON 매니저 프로토콜.
protocol JSONManagerType {

  /// 주어진 데이터를 특정 타입으로 디코딩함.
  func fetchJSONObject<T: Decodable>(to type: T.Type, resourceName: String) -> [T]
}
