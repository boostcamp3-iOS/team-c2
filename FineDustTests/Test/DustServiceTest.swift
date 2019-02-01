//
//  DustServiceTest.swift
//  FineDustTests
//
//  Created by Presto on 01/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import XCTest
import Foundation

class DustServiceTest: XCTestCase {
  
  var dustService: DustService!
  
  let mockDustManager = MockDustManager()
  
  private lazy var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm"
    return formatter
  }()
  
  override func setUp() {
    dustService = DustService(dustManager: mockDustManager)
    
  }
  
  override func tearDown() {
    
  }
  
  func test_fetchCurrentDustInfo() {
    let expect = expectation(description: "test")
    mockDustManager.dustResponse = DustManagerInfo.dummyDustResponse
    dustService?.fetchCurrentResponse { dustInfo, error in
      XCTAssertEqual(dustInfo?.currentFineDustGrade ?? .default, DustGrade.good)
      XCTAssertEqual(dustInfo?.currentUltraFineDustGrade ?? .default, DustGrade.good)
      XCTAssertEqual(dustInfo?.currentFineDustValue ?? 0, 1)
      XCTAssertEqual(dustInfo?.currentUltraFineDustValue ?? 0, 1)
      XCTAssertEqual(dustInfo?.recentUpdatingTime ?? Date(),
                     self.dateFormatter.date(from: "2018-01-23 17:00"))
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_fetchCurrentDustInfo_error() {
    let expect = expectation(description: "test")
    mockDustManager.dustResponse = nil
    mockDustManager.error = NSError(domain: "domain", code: 0, userInfo: nil)
    dustService.fetchCurrentResponse { dustInfo, error in
      XCTAssertNil(dustInfo)
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_fetchTodayDust() {
    let expect = expectation(description: "test")
    mockDustManager.dustResponse = DustManagerInfo.dummyDustResponse
    dustService.fetchTodayDust { fineDustDictionary, ultrafineDustDictionary, error in
      XCTAssertEqual(fineDustDictionary, [.seventeen: 1])
      XCTAssertEqual(ultrafineDustDictionary, [.seventeen: 1])
      XCTAssertNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_fetchTodayDust_error() {
    let expect = expectation(description: "test")
    mockDustManager.dustResponse = DustManagerInfo.dummyDustResponse
    mockDustManager.error = NSError(domain: "", code: 0, userInfo: nil)
    dustService.fetchTodayDust { fineDustDictionary, ultrafineDustDictionary, error in
      XCTAssertNil(fineDustDictionary)
      XCTAssertNil(ultrafineDustDictionary)
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
}
