//
//  MockJSONManager.swift
//  FineDustTests
//
//  Created by 이재은 on 12/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import Foundation

final class MockJSONManager: JSONManagerType {

  var dustFeedbacks: [DustFeedback] = []
  
//  let emptyJSONData = {[]}
//  let mockJSONData = {[
//    "title": "미", "imageName": "T", "source": "K", "date": "2018-12-15", "contents": " 틸"],
//  ["title": "미", "imageName": "T", "source": "K", "date": "2018-12-15", "contents": " 틸"],
//  ["title": "미", "imageName": "T", "source": "K", "date": "2018-12-15", "contents": " 틸"],
//  ["title": "미", "imageName": "T", "source": "K", "date": "2018-12-15", "contents": " 틸"]
//    ]}
  
  func fetchDustFeedbacks() -> [DustFeedback] {
    return dustFeedbacks
  }
}
