//
//  CoreDataServiceTest.swift
//  FineDustTests
//
//  Created by Presto on 12/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import Foundation
import XCTest

class TestCoreDataService: XCTestCase {
  
  let mockCoreDataUserManager = MockCoreDataUserManager()
  
  let mockCoreDataIntakeManager = MockCoreDataIntakeManager()
  
  var coreDataService: CoreDataService!
  
  override func setUp() {
    coreDataService = CoreDataService(userManager: mockCoreDataUserManager, intakeManager: mockCoreDataIntakeManager)
  }
  
  func test_requestLastAccessedDate() {
    let expect = expectation(description: "test")
    let user = User(context: mockCoreDataUserManager.context)
    user.lastAccessedDate = Date.start()
    mockCoreDataUserManager.user = user
    mockCoreDataUserManager.error = nil
    coreDataService.requestLastAccessedDate { date, error in
      XCTAssertEqual(date, Date.start())
      XCTAssertNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_saveLastAccessedDate() {
    let expect = expectation(description: "test")
    mockCoreDataUserManager.dictionary = [User.lastAccessedDate: Date.start()]
    mockCoreDataUserManager.error = nil
    coreDataService.saveLastAccessedDate { error in
      XCTAssertNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_requestIntakes() {
    let expect = expectation(description: "test")
    let intake1 = Intake(context: mockCoreDataIntakeManager.context)
    intake1.date = Date.before(days: 2).start
    intake1.fineDust = 10
    intake1.ultrafineDust = 10
    let intake2 = Intake(context: mockCoreDataIntakeManager.context)
    intake2.date = Date.before(days: 1).start
    intake2.fineDust = 20
    intake2.ultrafineDust = 20
    mockCoreDataIntakeManager.intakes = [intake1, intake2]
    mockCoreDataIntakeManager.error = nil
    coreDataService.requestIntakes(from: .before(days: 2), to: .before(days: 1)) { intakePerDate, error in
      XCTAssertNotNil(intakePerDate)
      XCTAssertNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_saveIntake() {
    coreDataService.saveIntake(100, 100, at: Date()) { error in
      
    }
  }
  
  func test_saveIntakes() {
    let expect = expectation(description: "test")
    mockCoreDataIntakeManager.error = nil
    var dates = 2
    coreDataService.saveIntakes([1, 1], [1, 1], at: [.before(days: 2), .before(days: 1)]) { error in
      XCTAssertNil(error)
      dates -= 1
      if dates == 0 {
        expect.fulfill()
      }
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_requestLastRequestedData() {
    let expect = expectation(description: "test")
    let user = User(context: mockCoreDataUserManager.context)
    user.todayFineDust = 0
    user.todayFineDust = 0
    user.distance = 0
    user.steps = 0
    user.address = ""
    user.grade = 0
    user.recentFineDust = 0
    mockCoreDataUserManager.user = user
    mockCoreDataUserManager.error = nil
    coreDataService.requestLastSavedData { lastSavedData, error in
      XCTAssertNotNil(lastSavedData)
      XCTAssertEqual(lastSavedData?.todayFineDust, 0)
      XCTAssertEqual(lastSavedData?.todayUltraFineDust, 0)
      XCTAssertEqual(lastSavedData?.distance, 0)
      XCTAssertEqual(lastSavedData?.steps, 0)
      XCTAssertEqual(lastSavedData?.address, "")
      XCTAssertEqual(lastSavedData?.grade, 0)
      XCTAssertEqual(lastSavedData?.recentFineDust, 0)
      XCTAssertNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_saveLastSteps() {
    let expect = expectation(description: "test")
    let user = User(context: mockCoreDataUserManager.context)
    mockCoreDataUserManager.user = user
    mockCoreDataUserManager.error = nil
    coreDataService.saveLastSteps(1) { error in
      XCTAssertNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_saveLastDistance() {
    let expect = expectation(description: "test")
    let user = User(context: mockCoreDataUserManager.context)
    mockCoreDataUserManager.user = user
    mockCoreDataUserManager.error = nil
    coreDataService.saveLastDistance(1) { error in
      XCTAssertNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_saveLastDustData() {
    let expect = expectation(description: "test")
    let user = User(context: mockCoreDataUserManager.context)
    mockCoreDataUserManager.user = user
    mockCoreDataUserManager.error = nil
    coreDataService.saveLastDustData("", 1, 1) { error in
      XCTAssertNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_saveLastTodayIntake() {
    let expect = expectation(description: "test")
    let user = User(context: mockCoreDataUserManager.context)
    mockCoreDataUserManager.user = user
    mockCoreDataUserManager.error = nil
    coreDataService.saveLastTodayIntake(1, 1) { error in
      XCTAssertNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_saveLastWeekIntake() {
    let expect = expectation(description: "test")
    let user = User(context: mockCoreDataUserManager.context)
    mockCoreDataUserManager.user = user
    mockCoreDataUserManager.error = nil
    coreDataService.saveLastWeekIntake([1, 1], [1, 1]) { error in
      XCTAssertNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_requestLastAccessedDate_error() {
    let expect = expectation(description: "test")
    mockCoreDataUserManager.user = nil
    mockCoreDataUserManager.error = NSError(domain: "coreDataError", code: 0, userInfo: nil)
    coreDataService.requestLastAccessedDate { date, error in
      XCTAssertNil(date)
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_requestLastAccessedDate_error2() {
    let expect = expectation(description: "test")
    mockCoreDataUserManager.user = nil
    mockCoreDataUserManager.error = nil
    coreDataService.requestLastAccessedDate { date, error in
      XCTAssertNil(date)
      XCTAssertNotNil(error)
      if let error = error as? CoreDataError {
        XCTAssertEqual(error, CoreDataError.noUser)
        XCTAssertEqual(error.localizedDescription, "등록된 사용자가 없습니다.")
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_saveLastAccessedDate_error() {
    let expect = expectation(description: "test")
    mockCoreDataUserManager.dictionary = [User.lastAccessedDate: Date.start()]
    mockCoreDataUserManager.error = NSError(domain: "coreDataError", code: 0, userInfo: nil)
    coreDataService.saveLastAccessedDate { error in
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_requestIntakes_error() {
    let expect = expectation(description: "test")
    mockCoreDataIntakeManager.intakes = nil
    mockCoreDataIntakeManager.error = NSError(domain: "coreDataError", code: 0, userInfo: nil)
    coreDataService.requestIntakes(from: Date(), to: Date()) { intakePerDate, error in
      XCTAssertNil(intakePerDate)
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_saveIntake_error() {
    let expect = expectation(description: "test")
    mockCoreDataIntakeManager.error = NSError(domain: "coreDataError", code: 0, userInfo: nil)
    coreDataService.saveIntake(100, 100, at: Date()) { error in
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
 
  func test_saveIntakes_error() {
    let expect = expectation(description: "test")
    mockCoreDataIntakeManager.error = NSError(domain: "count not matched", code: 0, userInfo: nil)
    coreDataService.saveIntakes([1], [1, 1], at: [.before(days: 2), .before(days: 1)]) { error in
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_requestLastRequestedData_error() {
    let expect = expectation(description: "teset")
    mockCoreDataUserManager.user = nil
    mockCoreDataUserManager.error = NSError(domain: "", code: 0, userInfo: nil)
    coreDataService.requestLastSavedData { lastSavedData, error in
      XCTAssertNil(lastSavedData)
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_requestLastRequestedData_error2() {
    let expect = expectation(description: "teset")
    mockCoreDataUserManager.user = nil
    mockCoreDataUserManager.error = nil
    coreDataService.requestLastSavedData { lastSavedData, error in
      XCTAssertNil(lastSavedData)
      XCTAssertNotNil(error)
      if let error = error as? CoreDataError {
        XCTAssertEqual(error, CoreDataError.noUser)
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_saveLastSteps_error() {
    let expect = expectation(description: "test")
    mockCoreDataUserManager.error = NSError(domain: "", code: 0, userInfo: nil)
    coreDataService.saveLastSteps(1) { error in
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_saveLastSteps_error2() {
    let expect = expectation(description: "test")
    mockCoreDataUserManager.user = nil
    mockCoreDataUserManager.error = nil
    coreDataService.saveLastSteps(1) { error in
      XCTAssertNotNil(error)
      if let error = error as? CoreDataError {
        XCTAssertEqual(error, CoreDataError.noUser)
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_saveLastDistance_error() {
    let expect = expectation(description: "test")
    mockCoreDataUserManager.error = NSError(domain: "", code: 0, userInfo: nil)
    coreDataService.saveLastDistance(1) { error in
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_saveLastDistance_error2() {
    let expect = expectation(description: "test")
    mockCoreDataUserManager.user = nil
    mockCoreDataUserManager.error = nil
    coreDataService.saveLastDistance(1) { error in
      XCTAssertNotNil(error)
      if let error = error as? CoreDataError {
        XCTAssertEqual(error, CoreDataError.noUser)
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_saveLastDustData_error() {
    let expect = expectation(description: "test")
    mockCoreDataUserManager.error = NSError(domain: "", code: 0, userInfo: nil)
    coreDataService.saveLastDustData("", 1, 1) { error in
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_saveLastDustData_error2() {
    let expect = expectation(description: "test")
    mockCoreDataUserManager.user = nil
    mockCoreDataUserManager.error = nil
    coreDataService.saveLastDustData("", 1, 1) { error in
      XCTAssertNotNil(error)
      if let error = error as? CoreDataError {
        XCTAssertEqual(error, CoreDataError.noUser)
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_saveLastTodayIntake_error() {
    let expect = expectation(description: "test")
    mockCoreDataUserManager.error = NSError(domain: "", code: 0, userInfo: nil)
    coreDataService.saveLastTodayIntake(1, 1) { error in
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_saveLastTodayIntake_error2() {
    let expect = expectation(description: "test")
    mockCoreDataUserManager.user = nil
    mockCoreDataUserManager.error = nil
    coreDataService.saveLastTodayIntake(1, 1) { error in
      XCTAssertNotNil(error)
      if let error = error as? CoreDataError {
        XCTAssertEqual(error, CoreDataError.noUser)
      } else {
        XCTFail()
      }
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_saveLastWeekIntake_error() {
    let expect = expectation(description: "test")
    mockCoreDataUserManager.error = NSError(domain: "", code: 0, userInfo: nil)
    mockCoreDataUserManager.error = nil
    coreDataService.saveLastWeekIntake([1, 1], [1, 1]) { error in
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_saveLastWeekIntake_error2() {
    let expect = expectation(description: "test")
    mockCoreDataUserManager.user = nil
    mockCoreDataUserManager.error = nil
    coreDataService.saveLastWeekIntake([1, 1], [1, 1]) { error in
      XCTAssertNotNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
}
