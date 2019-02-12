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
    coreDataService.requestLastAccessedDate { date, error in
      
    }
  }
  
  func test_saveLastAccessedDate() {
    coreDataService.saveLastAccessedDate { error in
      
    }
  }
  
  func test_requestIntakes() {
    coreDataService.requestIntakes(from: Date(), to: Date()) { intakePerDate, error in
      
    }
  }
  
  func test_saveIntakes() {
    coreDataService.saveIntake(100, at: Date()) { error in
      
    }
  }
  
  func test_requestLastAccessedDate_error() {
    coreDataService.requestLastAccessedDate { date, error in
      
    }
  }
  
  func test_saveLastAccessedDate_error() {
    coreDataService.saveLastAccessedDate { error in
      
    }
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
