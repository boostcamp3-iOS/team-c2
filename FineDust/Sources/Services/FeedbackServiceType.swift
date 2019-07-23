//
//  FeedbackListServiceType.swift
//  FineDust
//
//  Created by 이재은 on 13/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

protocol FeedbackServiceType: class {
  
  /// 정보의 제목으로 즐겨찾기 여부를 저장함.
  var isBookmarkedByTitle: [String: Bool] { get set }
  
  /// 즐겨찾기한 글의 제목을 저장하여 배열 처리함.
  func saveBookmark(by title: String)
  
  /// 저장했던 즐겨찾기 정보 제목을 삭제함.
  func deleteBookmark(by title: String)
  
  /// 제목으로 피드백 전체 정보를 가져옴.
  func fetchFeedback(by title: String) -> Contents?
 
  /// 현재 상태로 피드백 정보를 가져옴.
  func fetchRecommededFeedbacks(by currentState: IntakeGrade) -> [Contents]
  
  /// 피드백 정보에서 해당 중요도를 가진 정보를 가져와서 섞음.
  func fetchFeedbacks(by importance: FeedbackImportance) -> [Contents]
}
