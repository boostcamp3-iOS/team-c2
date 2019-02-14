//
//  FeedbackListService.swift
//  FineDust
//
//  Created by 이재은 on 11/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// FeedbackListService를 구현하는 클래스
final class FeedbackListService: FeedbackServiceType {
  
  private var dustFeedbacks: [DustFeedback] = []
  let jsonManager: JSONManagerType
  
  init(jsonManager: JSONManagerType) {
    self.jsonManager = jsonManager
    dustFeedbacks =  jsonManager.fetchDustFeedbacks()
  }
  
  /// 피드백 정보의 개수를 반환함.
  func fetchFeedbackCount() -> Int {
    
    let count = dustFeedbacks.count
    return count
  }
  
  /// 해당 인덱스의 피드백 정보를 반환함
  func fetchFeedbackData(at index: Int) -> DustFeedback {
    return dustFeedbacks[index]
  }
  
  /// 피드백 정보를 최신순으로 반환함
  func fetchFeedbackRecentDate() -> [DustFeedback] {
    let sortedArray = dustFeedbacks.sorted(by: { $0.date > $1.date })
    print(sortedArray)
    return sortedArray
  }
  
  /// 피드백 정보를 제목순으로 반환함
  func fetchFeedbackTitle() -> [DustFeedback] {
    let sortedArray = dustFeedbacks.sorted(by: { $0.title < $1.title })
    
    return sortedArray
  }
  
}
