//
//  DustFeedback.swift
//  FineDust
//
//  Created by 이재은 on 07/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

struct FeedbackContents: Codable {
  
  let title: String
  
  let imageName: String
  
  let importance: Int
  
  let source: String
  
  let date: String
  
  let contents: String
}
