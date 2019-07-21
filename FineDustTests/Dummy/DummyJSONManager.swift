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
  
  static let emptyJSONData: [FeedbackContents] = []
  
  static let JSONData: [FeedbackContents] = [FineDust.FeedbackContents(title: "미세먼지 정화 식물 \'틸란드시아\'", imageName: "Tillandsia", importance: 1, source: "KTV 국민방송", date: "2018-12-15", contents: " 틸란드"), FineDust.FeedbackContents(title: "서울 미세먼지 정책/비상저감조치", imageName: "seoul", importance: 3, source: "서울시 공식 블로그", date: "2018-11-22", contents: "미세먼지"), FineDust.FeedbackContents(title: "실내 환기 요령", imageName: "Ventilation", importance: 3, source: "네이버 지식백과", date: "2018-11-27", contents: " 외부 "), FineDust.FeedbackContents(title: "비타민 B의 효능과 돼지고기", imageName: "vitaminB", importance: 3, source: "허프 포스트", date: "2017-05-04", contents: " 10명"), FineDust.FeedbackContents(title: "코로 숨쉬어야 하는 필요성", imageName: "nose", importance: 1, source: "허프 포스트", date: "2017-05-09", contents: " 초미세먼지는 워낙 작아 폐포."), FineDust.FeedbackContents(title: "고농도 미세먼지 단계별 대응요령", imageName: "steps", importance: 1, source: "환경부", date: "2018-05-25", contents: "1단계"), FineDust.FeedbackContents(title: "7가지 대응요령", imageName: "sevenSteps", importance: 3, source: "환경부", date: "2019-01-30", contents: "1. 외"), FineDust.FeedbackContents(title: "영유아 평시 대응요령", imageName: "childrenSteps", importance: 2, source: "환경부", date: "2018-12-21", contents: "고농."), FineDust.FeedbackContents(title: "원아 학생 평시 대응요령", imageName: "studentSteps", importance: 2, source: "환경부", date: "2018-03-22", contents: "고"), FineDust.FeedbackContents(title: "어르신 평시 대응요령", imageName: "oldSteps", importance: 2, source: "환경부", date: "2018-09-14", contents: "고농도 미.")]
}

