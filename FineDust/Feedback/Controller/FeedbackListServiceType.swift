//
//  FeedbackListServiceType.swift
//  FineDust
//
//  Created by 이재은 on 13/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// FeedbackListService Type.
protocol FeedbackListServiceType: class {
  
  /// 피드백 정보의 개수를 반환함.
  func fetchFeedbackCount() throws -> Int
  
  /// 해당 인덱스의 피드백 정보를 반환함
  func fetchFeedbackData(at index: Int) -> DustFeedback
  
  /// 피드백 정보를 최신순으로 반환함
  func fetchFeedbackRecentDate() -> [DustFeedback]
  
  /// 피드백 정보를 제목순으로 반환함
  func fetchFeedbackTitle() -> [DustFeedback]
  
  /// 즐겨찾기한 글의 제목을 저장하여 배열 처리함.
  func setBookmarkInfoTitleArray(title: String)
  
  /// 즐겨찾기한 글의 제목으로 인덱스를 반환함
  func getBookmarkInfoIndex() -> [Int]

  /// 피드백 정보를 즐겨찾기순으로 반환함
  func fetchFeedbackBookmark() -> [DustFeedback]
}
