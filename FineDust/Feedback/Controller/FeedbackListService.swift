//
//  FeedbackListService.swift
//  FineDust
//
//  Created by 이재은 on 11/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// FeedbackListService를 구현하는 클래스
final class FeedbackListService: FeedbackListServiceType {
  
  // MARK: - Properties
  
  let jsonManager: JSONManagerType
  private var dustFeedbacks: [DustFeedback] = []
  private var sortedArray: [DustFeedback] = []
  private var bookmarkInfoTitleArray: [String] = []
  private var bookmarkIndex: [Int] = []
  init(jsonManager: JSONManagerType) {
    self.jsonManager = jsonManager
    dustFeedbacks =  jsonManager.fetchDustFeedbacks()
  }
  
  // MARK: - Functions
  
  /// 피드백 정보의 개수를 반환함.
  func fetchFeedbackCount() throws -> Int {
    let count = dustFeedbacks.count
    if count == 0 {
      throw NSError(domain: "nanana", code: 0, userInfo: nil)
    }
    return count
  }
  
  /// 해당 인덱스의 피드백 정보를 반환함.
  func fetchFeedbackData(at index: Int) -> DustFeedback {
    return dustFeedbacks[index]
  }
  
  /// 피드백 정보를 최신순으로 반환함.
  func fetchFeedbackRecentDate() -> [DustFeedback] {
    sortedArray = dustFeedbacks.sorted(by: { $0.date > $1.date })
    return sortedArray
  }
  
  /// 피드백 정보를 제목순으로 반환함.
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
  
  /// 즐겨찾기한 글의 제목으로 인덱스를 반환함.
  func getBookmarkInfoIndex() -> [Int] {
    bookmarkIndex = []
    print(bookmarkIndex)
    for index in 0..<bookmarkInfoTitleArray.count {
      print("f\(bookmarkInfoTitleArray)")
      for totalIndex in 0..<dustFeedbacks.count {
        print("df\(dustFeedbacks.count)")
        if bookmarkInfoTitleArray[index] == dustFeedbacks[totalIndex].title {
          print(dustFeedbacks.index(after: totalIndex-1))
          bookmarkIndex.append(dustFeedbacks.index(after: totalIndex-1))
          break
        }
      }
    }
    return bookmarkIndex
  }
  
  /// 피드백 정보를 즐겨찾기순으로 반환함.
  func fetchFeedbackBookmark() -> [DustFeedback] {
    sortedArray = []
    var feedbackIndex = Array<Int>(0..<dustFeedbacks.count)
    var bookmarkIndexArray = getBookmarkInfoIndex()
    for index in 0..<bookmarkIndexArray.count {
      sortedArray.append(dustFeedbacks[bookmarkIndexArray[index]])
    }
    
    for index in (0..<bookmarkIndexArray.count).reversed() {
      for totalIndex in 0..<dustFeedbacks.count {
        if bookmarkIndexArray[index] == feedbackIndex[totalIndex] {
          feedbackIndex.remove(at: totalIndex)
          break
        }
      }
    }
    for restIndex in 0..<feedbackIndex.count {
      sortedArray.append(dustFeedbacks[feedbackIndex[restIndex]])
    }
    return sortedArray
  }
  
  /// 저장했던 즐겨찾기 정보 제목을 삭제함.
  func deleteFeedbackTitle(title: String) {
    for index in 0..<bookmarkInfoTitleArray.count {
      if title == bookmarkInfoTitleArray[index] {
        bookmarkInfoTitleArray.remove(at: index)
      }
    }
  }
}
