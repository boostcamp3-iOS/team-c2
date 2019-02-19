//
//  JSONManager.swift
//  FineDust
//
//  Created by 이재은 on 09/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// JSON 매니저.
final class JSONManager: JSONManagerType {
  
  // MARK: - Properties

  let jsonDecoder = JSONDecoder()
  
  // MARK: - Fucntion
  
  /// json 파싱하여 데이터를 가져옴.
  func fetchJSONObject<T>(to type: T.Type, resourceName: String) -> [T] where T : Decodable {
    guard let path = Bundle.main.path(forResource: resourceName, ofType: "json") else { return [] }
    
    do {
      guard let data = try String(contentsOfFile: path).data(using: .utf8) else { return [] }
      let response: [T] = try jsonDecoder.decode([T].self, from: data)
      return response
    } catch {
      print(error)
      return []
    }
  }
}
