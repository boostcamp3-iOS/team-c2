//
//  DummyJSONManager.swift
//  FineDustTests
//
//  Created by 이재은 on 13/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

@testable import FineDust
import Foundation

struct DummyJSONManager {
  
  enum DustFeedback {
    case title(String)
    case imageName(String)
    case source(String)
    case date(String)
    case contents(String)
  }
  
  static let emptyJSONData: [DustFeedback] = .object([:])
  
  static let JSONData: [DustFeedback] = .object(
    [title: "미", imageName: "T", source: "K", date: "2018-12-10", contents: " 틸"],
     [title: "미", imageName: "a", source: "K", date: "2018-12-11", contents: " 틸"],
     [title: "미", imageName: "x", source: "K", date: "2018-12-12", contents: " 틸"],
     [title: "미", imageName: "e", source: "K", date: "2018-12-13", contents: " 틸"]
  )
}

