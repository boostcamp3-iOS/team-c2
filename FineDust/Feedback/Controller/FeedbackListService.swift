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
  
  private let jsonManager: JSONManagerType?
  private var dustFeedbacks: [DustFeedback] = []
  private let userDefaultsKey = "isBookmarkedByTitle"
  private let resourceName = "DustFeedback"
  var isBookmarkedByTitle: [String: Bool] {
    get {
      return UserDefaults.standard.dictionary(forKey: userDefaultsKey) as? [String: Bool] ?? [:]
    }
    set {
      UserDefaults.standard.set(newValue, forKey: userDefaultsKey)
    }
  }
  
  init(jsonManager: JSONManagerType = JSONManager()) {
    self.jsonManager = jsonManager
    dustFeedbacks = jsonManager.fetchJSONObject(to: DustFeedback.self, resourceName: resourceName)
  }
  
  // MARK: - Functions
  
  /// 피드백 정보의 개수를 반환함.
  func fetchFeedbackCount() -> Int {
    let count = dustFeedbacks.count
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
  
  /// 즐겨찾기한 글의 제목을 저장함.
  func saveBookmark(by title: String) {
    isBookmarkedByTitle[title] = true
  }
  
  /// 저장했던 즐겨찾기 정보 제목을 삭제함.
  func deleteBookmark(by title: String) {
    isBookmarkedByTitle[title] = false
  }
  
  /// 제목으로 피드백 전체 정보를 가져옴.
  func fetchFeedback(by title: String) -> DustFeedback? {
    return dustFeedbacks.filter { $0.title == title }.first
  }
  
  /// 현재 상태로 피드백 정보를 가져옴.
  func fetchRecommededFeedbacks(by currentState: IntakeGrade) -> [DustFeedback] {
    var recommendCount: [ImportanceGrade: Int] = [:] // 중요도별 개수
    switch currentState {
    case .veryGood:
      recommendCount = [.important: 2, .normal: 1]
    case .good:
      recommendCount = [.important: 3]
    case .normal:
      recommendCount = [.veryImportant: 1, .important: 2]
    case .bad:
      recommendCount = [.veryImportant: 2, .important: 1]
    case .veryBad:
      recommendCount = [.veryImportant: 3]
    default:
      recommendCount = [.important: 2, .normal: 1]
    }
    var importantDustFeedbacks: [DustFeedback] = [] // 중요도별 전체 정보
    let recommendImportance = recommendCount.keys.map { $0 } // 가져올 중요도
 
    var recommendFeedbacks: [DustFeedback] = []
    for index in 0..<recommendImportance.count {
      importantDustFeedbacks = fetchFeedbacks(by: recommendImportance[index].rawValue)
      // 중요도별 개수로 추천 정보 결정
      let importanceKey = recommendImportance[index]
      if let importanceCount = recommendCount[importanceKey] {
        for count in 0..<importanceCount {
          recommendFeedbacks.append(importantDustFeedbacks[count])
        }
      }
    }
    return recommendFeedbacks
  }
  
  /// 피드백 정보에서 해당 중요도를 가진 정보를 가져와서 섞음.
  func fetchFeedbacks(by importance: Int) -> [DustFeedback] {
    let feedbacks = dustFeedbacks.filter { $0.importance == importance }
    return feedbacks.shuffled()
  }
}
