//
//  JSONManager.swift
//  FineDust
//
//  Created by 이재은 on 09/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

final class JSONManager: JSONManagerType {
  
  private let jsonDecoder = JSONDecoder()
  
  func parse<T>(_ resourceName: String, to type: T.Type) -> T? where T: Decodable {
    guard let path = Bundle.main.path(forResource: resourceName, ofType: "json") else {
      return nil
    }
    guard let optionalData = try? String(contentsOfFile: path).data(using: .utf8) else { return nil }
    guard let data = optionalData else { return nil }
    let jsonObject = try? jsonDecoder.decode(T.self, from: data)
    return jsonObject
  }
}
