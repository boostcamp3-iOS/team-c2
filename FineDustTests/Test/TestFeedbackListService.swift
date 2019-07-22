//
//  TestFeedbackListService.swift
//  FineDustTests
//
//  Created by 이재은 on 12/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import XCTest
import Foundation

class FeedbackListServiceTest: XCTestCase {
  
  var feedbackListService: FeedbackService!
  let mockJSONManager = MockJSONManager()
  
  override func setUp() {
    mockJSONManager.dustFeedbacks = DummyJSONManager.JSONData
    feedbackListService = FeedbackService(jsonManager: mockJSONManager)
  }
  
  /// 오늘 피드백 데이터 개수 받아오는 함수 테스트
  func testFeedbackCount() {
    let result = feedbackListService.fetchFeedbackCount()
    XCTAssertEqual(result, mockJSONManager.dustFeedbacks.count)
  }
  
  /// 피드백 정보를 최신순으로 반환하는 함수 테스트
  func testFetchFeedbackResentDate() {
    let result = feedbackListService.fetchFeedbacksByRecentDate()
    XCTAssertNotNil(result)
  }
  
  /// 피드백 정보를 제목순으로 반환하는 함수 테스트
  func testFetchFeedbackTitle() {
    let result = feedbackListService.fetchFeedbacksByTitle()
    XCTAssertNotNil(result)
  }
  
  /// 피드백 정보를 즐겨찾기순으로 반환하는 함수 테스트
  func testFetchFeedbackBookmark() {
    let result = feedbackListService.fetchFeedbacksByBookmark()
    XCTAssertNotNil(result)
  }
  
  /// 즐겨찾기한 글의 제목을 저장하는 함수 테스트
  func testSaveBookmark() {
    XCTAssertNotNil(feedbackListService.saveBookmark(by: mockJSONManager.dustFeedbacks[0].title))
  }
  
  /// 저장했던 즐겨찾기 정보 제목을 삭제하는 함수 테스트
  func testDeleteBookmark() {
    XCTAssertNotNil(feedbackListService.deleteBookmark(by: "data"))
  }
  
  /// 제목으로 피드백 전체 정보를 가져오는 함수 테스트
  func testFetchFeedback() {
    let title = mockJSONManager.dustFeedbacks[0].title
    let result = feedbackListService.fetchFeedback(by: title)
    XCTAssertNotNil(result)
  }
  
  /// 현재 상태로 피드백 정보를 가져오는 함수 테스트 default
  func testFetchRecommedFeedbackDefault() {
    let state = IntakeGrade.default
    let result = feedbackListService.fetchRecommededFeedbacks(by: state)
    XCTAssertNotNil(result)
  }
  
  /// 현재 상태로 피드백 정보를 가져오는 함수 테스트 1
  func testFetchRecommedFeedbackState1() {
    let state = IntakeGrade.veryBad
    let result = feedbackListService.fetchRecommededFeedbacks(by: state)
    XCTAssertNotNil(result)
  }
  
  /// 현재 상태로 피드백 정보를 가져오는 함수 테스트 2
  func testFetchRecommedFeedbackState2() {
    let state = IntakeGrade.bad
    let result = feedbackListService.fetchRecommededFeedbacks(by: state)
    XCTAssertNotNil(result)
  }
  
  /// 현재 상태로 피드백 정보를 가져오는 함수 테스트 3
  func testFetchRecommedFeedbackState3() {
    let state = IntakeGrade.normal
    let result = feedbackListService.fetchRecommededFeedbacks(by: state)
    XCTAssertNotNil(result)
  }
  
  /// 현재 상태로 피드백 정보를 가져오는 함수 테스트 4
  func testFetchRecommedFeedbackState4() {
    let state = IntakeGrade.good
    let result = feedbackListService.fetchRecommededFeedbacks(by: state)
    XCTAssertNotNil(result)
  }
  
  /// 현재 상태로 피드백 정보를 가져오는 함수 테스트 5
  func testFetchRecommedFeedbackState5() {
    let state = IntakeGrade.veryGood
    let result = feedbackListService.fetchRecommededFeedbacks(by: state)
    XCTAssertNotNil(result)
  }
  
  /// 피드백 정보에서 해당 중요도를 가진 정보를 가져와서 섞는 함수 테스트
  func testFetchImportantFeedbacks() {
    let importance = FeedbackImportance.normal
    var result = feedbackListService.fetchFeedbacks(by: importance)
    result = result.filter { $0.importance == importance.rawValue }
    XCTAssertNotNil(result)
  }
  
}
