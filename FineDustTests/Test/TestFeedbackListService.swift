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
  
  var feedbackListService: FeedbackListService?
  let mockJSONManager = MockJSONManager()
  
  override func setUp() {
    feedbackListService = FeedbackListService(jsonManager: mockJSONManager)
    
  }
  
  /// 오늘 피드백 데이터 개수 받아오는 함수 테스트
  func testFeedbackCount() {
//    mockJSONManager.dustFeedbacks = mockJSONManager.fetchDustFeedbacks() DummyJSONManager.JSONData
    let result = feedbackListService?.fetchFeedbackCount()
    XCTAssertEqual(result, mockJSONManager.dustFeedbacks.count)

  }
  
  /// 해당 인덱스의 피드백 정보를 반환하는 함수 테스트
  func testFetchFeedbackData() {

  }
  
  /// 피드백 정보를 최신순으로 반환하는 함수 테스트
  func testFetchFeedbackResentDate(){

  }
  
  /// 피드백 정보를 제목순으로 반환하는 함수 테스트
  func testFetchFeedbackTitle() {

  }
}
