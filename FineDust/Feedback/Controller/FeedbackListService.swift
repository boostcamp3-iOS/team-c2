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
  
  // MARK: - Properties
  
  let jsonManager: JSONManagerType
  private var dustFeedbacks: [DustFeedback] = []
  private var sortedArray: [DustFeedback] = []
  private var bookmarkInfoTitleArray: [String] = []
  
  init(jsonManager: JSONManagerType) {
    self.jsonManager = jsonManager
    dustFeedbacks =  jsonManager.fetchDustFeedbacks()
  }
  
  // MARK: - Functions
  
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
    sortedArray = dustFeedbacks.sorted(by: { $0.date > $1.date })
    return sortedArray
  }
  
  /// 피드백 정보를 제목순으로 반환함
  func fetchFeedbackTitle() -> [DustFeedback] {
    sortedArray = dustFeedbacks.sorted(by: { $0.title < $1.title })
    return sortedArray
  }
  
  /// 즐겨찾기한 글의 제목을 저장하여 배열 처리함.
  func setBookmarkInfoTitleArray(title: String) {
    UserDefaults.standard.set(title, forKey: "bookmarkInfoTitle")
    if let bookmarkInfoTitle = UserDefaults.standard.string(forKey: "bookmarkInfoTitle") {
      bookmarkInfoTitleArray.append(bookmarkInfoTitle)
    }
  }
  
  /// 즐겨찾기한 글의 제목으로 인덱스를 반환함
  func getBookmarkInfoIndex() -> [Int] {
    var bookmarkIndex: [Int] = []
    print(bookmarkIndex)
    for index in 0..<bookmarkInfoTitleArray.count {
      print("f\(bookmarkInfoTitleArray.count)")
      for index2 in 0..<dustFeedbacks.count {
        print("df\(dustFeedbacks.count)")
        if dustFeedbacks[index2].title == bookmarkInfoTitleArray[index] {
          print(dustFeedbacks.index(after: index2-1))
          bookmarkIndex.append(dustFeedbacks.index(after: index2-1))
          break
        }
      }
    }
    return bookmarkIndex
  }
  
  /// 피드백 정보를 즐겨찾기순으로 반환함
  func fetchFeedbackBookmark() -> [DustFeedback] {
    var feedbackIndex = Array<Int>(0..<dustFeedbacks.count)
    let bookmarkIndexArray = getBookmarkInfoIndex()
    
    for index2 in (0..<bookmarkIndexArray.count).reversed() {
      sortedArray.append(dustFeedbacks[bookmarkIndexArray[index2]])
      for index in 0..<dustFeedbacks.count {
        if bookmarkIndexArray[index2] == feedbackIndex[index] {
          feedbackIndex.remove(at: index)
          break
        }
      }
    }
    for index2 in 0..<feedbackIndex.count {
      sortedArray.append(dustFeedbacks[feedbackIndex[index2]])
    }
    return sortedArray
  }
  
}
