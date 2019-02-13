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
    intake1.value = 10
    let intake2 = Intake(context: mockCoreDataIntakeManager.context)
    intake2.date = Date.before(days: 1).start
    intake2.value = 20
    mockCoreDataIntakeManager.intakes = [intake1, intake2]
    mockCoreDataIntakeManager.error = nil
    coreDataService.requestIntakes(from: .before(days: 2), to: .before(days: 1)) { intakePerDate, error in
      XCTAssertEqual(intakePerDate, [Date.before(days: 2).start: 10, Date.before(days: 1).start: 20])
      XCTAssertNil(error)
      expect.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
  }
  
  func test_saveIntakes() {
    coreDataService.saveIntake(100, at: Date()) { error in
      
    }
  }
  
  func test_requestLastAccessedDate_error() {
    let expect = expectation(description: "test")
    mockCoreDataUserManager.user = nil
    mockCoreDataUserManager.error = NSError(domain: "coreDataError", code: 0, userInfo: nil)
    coreDataService.requestLastAccessedDate { date, error in
      XCTAssertNotNil(date)
      XCTAssertNotNil(error)
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
    coreDataService.requestIntakes(from: Date(), to: Date()) { intakePerDate, error in
      
    }
  }
  
  func test_saveIntake_error() {
    coreDataService.saveIntake(100, at: Date()) { error in
      
    }
  }
}
