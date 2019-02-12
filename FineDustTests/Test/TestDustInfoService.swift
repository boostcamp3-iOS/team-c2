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

class TestDustInfoService: XCTestCase {
  
  var dustService: DustInfoService!
  
  let mockDustInfoManager = MockDustInfoManager()
  
  private lazy var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm"
    return formatter
  }()
  
  override func setUp() {
    mockDustInfoManager.networkManager = MockNetworkManager()
    dustService = DustInfoService(dustManager: mockDustInfoManager)
    
  }
  
  func test_requestRecentTimeInfo() {
    let expect = expectation(description: "test")
    mockDustInfoManager.dustResponse = DummyDustInfoManager.dustResponse
    dustService?.requestRecentTimeInfo { dustInfo, error in
      XCTAssertEqual(dustInfo?.fineDustGrade ?? .default, DustGrade.good)
      XCTAssertEqual(dustInfo?.ultrafineDustGrade ?? .default, DustGrade.good)
      XCTAssertEqual(dustInfo?.fineDustValue ?? 0, 1)
      XCTAssertEqual(dustInfo?.ultrafineDustValue ?? 0, 1)
      XCTAssertEqual(dustInfo?.updatingTime ?? Date(),
                     self.dateFormatter.date(from: "2018-01-23 17:00"))
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_requestRecentTimeInfo_error() {
    let expect = expectation(description: "test")
    mockDustInfoManager.dustResponse = nil
    mockDustInfoManager.error = NSError(domain: "domain", code: 0, userInfo: nil)
    dustService.requestRecentTimeInfo { dustInfo, error in
      XCTAssertNil(dustInfo)
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_requestDayInfo() {
    let expect = expectation(description: "test")
    mockDustInfoManager.dustResponse = DummyDustInfoManager.dustResponse24
    dustService.requestDayInfo { fineDustDictionary, ultrafineDustDictionary, error in
      XCTAssertEqual(fineDustDictionary, [.zero: 1, .one: 1, .two: 1, .three: 1, .four: 1, .five: 1, .six: 1, .seven: 1, .eight: 1, .nine: 1, .ten: 1, .eleven: 1, .twelve: 1, .thirteen: 1, .fourteen: 1, .fifteen: 1, .sixteen: 1, .seventeen: 1, .eighteen: 1, .nineteen: 1, .twenty: 1, .twentyOne: 1, .twentyTwo: 1, .twentyThree: 1])
      XCTAssertEqual(ultrafineDustDictionary, [.zero: 1, .one: 1, .two: 1, .three: 1, .four: 1, .five: 1, .six: 1, .seven: 1, .eight: 1, .nine: 1, .ten: 1, .eleven: 1, .twelve: 1, .thirteen: 1, .fourteen: 1, .fifteen: 1, .sixteen: 1, .seventeen: 1, .eighteen: 1, .nineteen: 1, .twenty: 1, .twentyOne: 1, .twentyTwo: 1, .twentyThree: 1])
      XCTAssertNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_requestDayInfo_error() {
    let expect = expectation(description: "test")
    mockDustInfoManager.dustResponse = nil
    mockDustInfoManager.error = NSError(domain: "", code: 0, userInfo: nil)
    dustService.requestDayInfo { fineDustDictionary, ultrafineDustDictionary, error in
      XCTAssertNil(fineDustDictionary)
      XCTAssertNil(ultrafineDustDictionary)
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_requestDayInfo2() {
    let expect = expectation(description: "test")
    mockDustInfoManager.dustResponse = DummyDustInfoManager.dustResponse24
    mockDustInfoManager.error = nil
    dustService.requestDayInfo(from: .before(days: 1), to: Date()) { fineDustHourlyIntakePerDate, ultrafineDustHourlyIntakePerDate, error in
      XCTAssertEqual(fineDustHourlyIntakePerDate, [Date(): [.zero: 1, .one: 1, .two: 1, .three: 1, .four: 1, .five: 1, .six: 1, .seven: 1, .eight: 1, .nine: 1, .ten: 1, .eleven: 1, .twelve: 1, .thirteen: 1, .fourteen: 1, .fifteen: 1, .sixteen: 1, .seventeen: 1, .eighteen: 1, .nineteen: 1, .twenty: 1, .twentyOne: 1, .twentyTwo: 1, .twentyThree: 1]])
      XCTAssertEqual(ultrafineDustHourlyIntakePerDate, [Date(): [.zero: 1, .one: 1, .two: 1, .three: 1, .four: 1, .five: 1, .six: 1, .seven: 1, .eight: 1, .nine: 1, .ten: 1, .eleven: 1, .twelve: 1, .thirteen: 1, .fourteen: 1, .fifteen: 1, .sixteen: 1, .seventeen: 1, .eighteen: 1, .nineteen: 1, .twenty: 1, .twentyOne: 1, .twentyTwo: 1, .twentyThree: 1]])
      XCTAssertNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_requestDayInfo2_error() {
    let expect = expectation(description: "test")
    mockDustInfoManager.dustResponse = nil
    mockDustInfoManager.error = NSError(domain: "", code: 0, userInfo: nil)
    dustService.requestDayInfo(from: .before(days: 1), to: Date()) { fineDustHourlyIntakePerDate, ultrafineDustHourlyIntakePerDate, error in
      XCTAssertNil(ultrafineDustHourlyIntakePerDate)
      XCTAssertNil(ultrafineDustHourlyIntakePerDate)
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
}
