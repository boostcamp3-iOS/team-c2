//
//  MockJSONManager.swift
//  FineDustTests
//
//  Created by Presto on 12/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import Foundation

final class MockJSONManager: JSONManagerType {

  var dustFeedbacks: [DustFeedback] = []
  var dustFeedbackZero: [DustFeedback] = []

  func fetchDustFeedbacks() -> [DustFeedback] {
    return dustFeedbacks
  }
}
