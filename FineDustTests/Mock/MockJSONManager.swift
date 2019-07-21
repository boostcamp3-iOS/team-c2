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

  var resourceName = "DustFeedback"
  var dustFeedbacks: [FeedbackContents] = []
  var emptyDustFeedback: [FeedbackContents] = []
  var error: Error?

  func fetchJSONObject<T>(to type: T.Type, resourceName: String) -> [T] where T : Decodable {
    return dustFeedbacks as? [T] ?? []
  }
}
