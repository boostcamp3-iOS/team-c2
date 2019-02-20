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
  
  var feedbackListService: FeedbackListService!
  let mockJSONManager = MockJSONManager()
  
  override func setUp() {
    mockJSONManager.dustFeedbacks = DummyJSONManager.JSONData
    feedbackListService = FeedbackListService(jsonManager: mockJSONManager)
  }
  
  /// 오늘 피드백 데이터 개수 받아오는 함수 테스트
  func testFeedbackCount() {
    let result = feedbackListService.fetchFeedbackCount()
    XCTAssertEqual(result, mockJSONManager.dustFeedbacks.count)
  }
  
  /// 해당 인덱스의 피드백 정보를 반환하는 함수 테스트
  func testFetchFeedbackData() {
    let index = 0
    let result = feedbackListService.fetchFeedback(at: index)
    XCTAssertNotNil(result)
    
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
}
