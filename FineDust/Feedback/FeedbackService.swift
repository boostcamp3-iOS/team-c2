//
//  FeedbackService.swift
//  FineDust
//
//  Created by 이재은 on 09/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

final class FeedbackService {
  func requestDustFeedbacks() {
    guard let path = Bundle.main.path(forResource: "DustFeedback", ofType: "json") else { return }
    let jsonDecoder: JSONDecoder = JSONDecoder()
    do {
      guard let data = try String(contentsOfFile: path).data(using: .utf8) else { return }
      let dustFeedbacks = try jsonDecoder.decode([DustFeedback].self, from: data)
      NotificationCenter.default
        .post(name: .didReceiveFeedback,
              object: nil,
              userInfo: ["feedbacks": dustFeedbacks])
    } catch {
      print("error: \(error)")
    }
  }
}
