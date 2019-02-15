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
  private let userDefaultsKey: String = "isBookmarkedByTitle"
  private var dustFeedbacks: [DustFeedback] = []
  private var isBookmarkedByTitle: [String: Bool] = [:]
  
  init(jsonManager: JSONManagerType) {
    self.jsonManager = jsonManager
    dustFeedbacks =  jsonManager.fetchDustFeedbacks()
    isBookmarkedByTitle
      = UserDefaults.standard.dictionary(forKey: userDefaultsKey) as? [String: Bool] ?? [:]
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
  func fetchFeedback(at index: Int) -> DustFeedback {
    return dustFeedbacks[index]
  }
  
  /// 피드백 정보를 최신순으로 반환함.
  func fetchFeedbacksByRecentDate() -> [DustFeedback] {
    return dustFeedbacks.sorted { $0.date > $1.date }
  }
  
  /// 피드백 정보를 제목순으로 반환함.
  func fetchFeedbacksByTitle() -> [DustFeedback] {
    return dustFeedbacks.sorted { $0.title < $1.title }
  }
  
  /// 피드백 정보를 즐겨찾기순으로 반환함.
  func fetchFeedbacksByBookmark() -> [DustFeedback] {
    var tempFeedbacks: [DustFeedback] = []
    var resultFeedbacks: [DustFeedback] = []
    for feedback in dustFeedbacks {
      if isBookmarkedByTitle[feedback.title] ?? false {
        tempFeedbacks.append(feedback)
      } else {
        resultFeedbacks.append(feedback)
      }
    }
    resultFeedbacks.insert(contentsOf: tempFeedbacks, at: 0)
    return resultFeedbacks
  }
  
  /// 즐겨찾기한 글의 제목을 저장하여 배열 처리함.
  func saveBookmark(by title: String) {
    if let isBookmarkedByTitle
      = UserDefaults.standard.dictionary(forKey: userDefaultsKey) as? [String: Bool] {
      var newDictionary = isBookmarkedByTitle
      newDictionary[title] = true
      UserDefaults.standard.set(newDictionary, forKey: userDefaultsKey)
    } else {
      UserDefaults.standard.set([title: true], forKey: userDefaultsKey)
    }
    isBookmarkedByTitle[title] = true
  }
  
  /// 저장했던 즐겨찾기 정보 제목을 삭제함.
  func deleteBookmark(by title: String) {
    isBookmarkedByTitle[title] = false
    if let isBookmarkedByTitle
      = UserDefaults.standard.dictionary(forKey: userDefaultsKey) as? [String: Bool] {
      var newDictionary = isBookmarkedByTitle
      newDictionary[title] = false
      UserDefaults.standard.set(newDictionary, forKey: userDefaultsKey)
    }
  }
  
  /// 제목으로 피드백 전체 정보를 가져옴.
  func fetchFeedbackbyTitle(title: String) -> DustFeedback {
    var result: DustFeedback?
    
    for feedback in 0..<dustFeedbacks.count {
      if title == dustFeedbacks[feedback].title {
        result = dustFeedbacks[feedback]
      }
    }
    return result ?? dustFeedbacks[0]
  }
}
