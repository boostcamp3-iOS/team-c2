//
//  FeedbackListService.swift
//  FineDust
//
//  Created by 이재은 on 11/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// FeedbackListService를 구현하는 클래스
final class FeedbackListService {

private let jsonManager = JSONManager()
private var dustFeedbacks: [DustFeedback] = []
  
  init() {
      dustFeedbacks =  jsonManager.fetchDustFeedbacks()
  }

  /// 피드백 정보의 개수를 반환함.
  func fetchFeedbackCount() -> Int {
    
    return dustFeedbacks.count
  }
  
  /// 해당 인덱스의 피드백 정보를 반환함
  func fetchFeedbackData(at index: Int) -> DustFeedback {
    return dustFeedbacks[index]
  }
  
}
