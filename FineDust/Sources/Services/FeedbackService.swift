//
//  FeedbackListService.swift
//  FineDust
//
//  Created by 이재은 on 11/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

final class FeedbackService: FeedbackServiceType {
  
  private enum Constant {
    
    static let userDefaultsKey = "isBookmarkedByTitle"
  }
  
  private var feedbackContents: [FeedbackContents] = []
  
  var isBookmarkedByTitle: [String: Bool] {
    get {
      return UserDefaults.standard.dictionary(forKey: Constant.userDefaultsKey) as? [String: Bool] ?? [:]
    }
    set {
      UserDefaults.standard.set(newValue, forKey: Constant.userDefaultsKey)
    }
  }
  
  init() {
    fetchFeedbackContents()
  }
  
  func fetchFeedbackContents() {
    let jsonDecoder = JSONDecoder()
    guard let path
      = Bundle.main.path(forResource: "FeedbackContents", ofType: "json") else { return }
    guard let optionalData = try? String(contentsOfFile: path).data(using: .utf8) else { return }
    guard let data = optionalData else { return }
    guard let jsonObject
      = try? jsonDecoder.decode([FeedbackContents].self, from: data) else { return }
    feedbackContents = jsonObject
  }
  
  // MARK: - Functions
  
  /// 피드백 정보의 개수를 반환함.
  func fetchFeedbackCount() -> Int {
    let count = feedbackContents.count
    return count
  }

  /// 피드백 정보를 최신순으로 반환함.
  func fetchFeedbacksByRecentDate() -> [FeedbackContents] {
    return feedbackContents.sorted { $0.date > $1.date }
  }
  
  /// 피드백 정보를 제목순으로 반환함.
  func fetchFeedbacksByTitle() -> [FeedbackContents] {
    return feedbackContents.sorted { $0.title < $1.title }
  }
  
  /// 피드백 정보를 즐겨찾기순으로 반환함.
  func fetchFeedbacksByBookmark() -> [FeedbackContents] {
    var tempFeedbacks: [FeedbackContents] = []
    var resultFeedbacks: [FeedbackContents] = []
    for feedback in feedbackContents {
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
  
  /// 제목으로 피드백 정보를 가져옴.
  func fetchFeedback(by title: String) -> FeedbackContents? {
    return feedbackContents.filter { $0.title == title }.first
  }
  
  /// 현재 상태로 피드백 정보를 가져옴.
  func fetchRecommededFeedbacks(by currentState: IntakeGrade) -> [FeedbackContents] {
    var recommendCount: [FeedbackImportance: Int] = [:] // 중요도별 개수
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
    var importantDustFeedbacks: [FeedbackContents] = [] // 중요도별 전체 정보
 
    var recommendFeedbacks: [FeedbackContents] = []
    for (key, _) in recommendCount {
      importantDustFeedbacks = fetchFeedbacks(by: key)
      // 중요도별 개수로 추천 정보 결정
      if let importanceCount = recommendCount[key] {
        for count in 0..<importanceCount {
          recommendFeedbacks.append(importantDustFeedbacks[count])
        }
      }
    }
    return recommendFeedbacks
  }
  
  /// 피드백 정보에서 해당 중요도를 가진 정보를 가져와서 섞음.
  func fetchFeedbacks(by importance: FeedbackImportance) -> [FeedbackContents] {
    let feedbacks = feedbackContents.filter { $0.importance == importance.rawValue }
    return feedbacks.shuffled()
  }
}
