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

//class IntakeServiceTest: XCTestCase {
//
//  var intakeService: IntakeService!
//
//  var mockHealthKitService: HealthKitServiceType!
//  var mockDustInfoService: DustInfoServiceType!
//  var mockCoreDataService: CoreDataServiceType!
//
//  override func setUp() {
//    intakeService = IntakeService(healthKitService: mockHealthKitService,
//                                  dustInfoService: mockDustInfoService,
//                                  coreDataService: mockCoreDataService)
//  }
//
//  func testFetchTodayIntake() {
//    intakeService.requestTodayIntake { fineDust, ultrafineDust, error in
//      XCTAssertNil(error)
//    }
//  }
//
//  func testFetchTodayIntakeError() {
//    intakeService.requestTodayIntake { fineDust, ultrafineDust, error in
//      XCTAssertNotNil(error)
//    }
//  }
//
//  func testFetchIntakesInWeek() {
//    intakeService.requestIntakesInWeek { fineDusts, ultrafineDusts, error in
//      XCTAssertNil(error)
//    }
//  }
//
//  func testFetchIntakesInWeekError() {
//    intakeService.requestIntakesInWeek { fineDusts, ultrafineDusts, error in
//      XCTAssertNotNil(error)
//    }
//  }
//}
