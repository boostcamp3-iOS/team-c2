//
//  DummyCoreDataService.swift
//  FineDustTests
//
//  Created by Presto on 12/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import Foundation

struct DummyCoreDataService {
  
  static let intakePerDateFull: DateIntakeValuePair = [Date.before(days: 6).start: (10, 10), Date.before(days: 5).start: (10, 10), Date.before(days: 4).start: (10, 10), Date.before(days: 3).start: (10, 10), Date.before(days: 2).start: (10, 10), Date.before(days: 1).start: (10, 10)]
  
  static let intakePerDateHalf: DateIntakeValuePair = [Date.before(days: 6).start: (10, 10), Date.before(days: 5).start: (10, 10), Date.before(days: 4).start: (10, 10)]
}
