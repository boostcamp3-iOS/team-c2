//
//  JSONManager.swift
//  FineDust
//
//  Created by 이재은 on 09/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

final class JSONManager: JSONManagerType {
  
  // MARK: - Properties
  
  var dustFeedbacks = [DustFeedbacks]()
  
  // MARK: - Fucntion
  
  /// DustFeedbacks json 파싱하여 데이터를 가져옴.
  func requestDustFeedbacks() -> [DustFeedbacks] {
    
    guard let path = Bundle.main.path(forResource: "DustFeedbacks",
                                      ofType: "json")
    else { return [] }
    let jsonDecoder = JSONDecoder()
    do {
      guard let data = try String(contentsOfFile: path).data(using: .utf8)
        else { return [] }
      dustFeedbacks = try jsonDecoder.decode([DustFeedbacks].self, from: data)
    } catch {
      print("error: \(error)")
    }
    return dustFeedbacks
  }
  
}
