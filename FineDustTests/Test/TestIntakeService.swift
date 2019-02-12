//
//  IntakeServiceTest.swift
//  FineDustTests
//
//  Created by Presto on 04/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import XCTest
import Foundation

class TestIntakeService: XCTestCase {
  
  let mockDustInfoService = MockDustInfoService()
  
  let mockHealthKitService = MockHealthKitService()
  
  let mockCoreDataService = MockCoreDataService()
  
  var intakeService: IntakeService!
  
  override func setUp() {
    intakeService = IntakeService(healthKitService: mockHealthKitService, dustInfoService: mockDustInfoService, coreDataService: mockCoreDataService)
  }
  
  func test_requestTodayIntake() {
    intakeService.requestTodayIntake { fineDust, ultrafineDust, error in
      
    }
  }
  
  func test_requestIntakesInWeek() {
    intakeService.requestIntakesInWeek { fineDusts, ultrafineDusts, error in
      
    }
  }
  
  func test_requestTodayIntake_error() {
    intakeService.requestTodayIntake { fineDust, ultrafineDust, error in
      
    }
  }
  
  func test_requestIntakesInWeek_error() {
    intakeService.requestIntakesInWeek { fineDusts, ultrafineDusts, error in
      
    }
  }
}
