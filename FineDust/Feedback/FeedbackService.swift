//
//  FeedbackService.swift
//  FineDust
//
//  Created by 이재은 on 09/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// FeedbackService를 구현하는 클래스 (미완)
final class FeedbackService {

  let jsonManager: JSONManagerType?

  fileprivate var dustFeedbacks: [DustFeedbacks] = []
  var result: [String] = []
  init(jsonManager: JSONManagerType) {
    self.jsonManager = jsonManager
    dustFeedbacks = jsonManager.fetchDustFeedbacks()
  }
  
//  func fetchImageName() -> [String] {
//    for i in 0..<dustFeedbacks.count {
//      result.append(dustFeedbacks[i].imageName)
//    }
//    return result
//  }
//  
//  func fetchTitle() -> [String] {
//    for i in 0..<dustFeedbacks.count {
//      result.append(dustFeedbacks[i].title)
//    }
//    return result
//  }
//  
//  func fetchSource() -> [String] {
//    for i in 0..<dustFeedbacks.count {
//      result.append(dustFeedbacks[i].source)
//    }
//    return result
//  }
}
