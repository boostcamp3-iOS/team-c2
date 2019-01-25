//
//  FineDustResponse.swift
//  FineDust
//
//  Created by Presto on 23/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// 미세먼지 정보 응답 객체.
struct FineDustResponse: Codable {
  
  struct List: Codable {
    
    let dataTime: String
    
    /// 미세먼지 농도
    private let fineDustValueResponse: String
    
    /// 미세먼지 24시간 예측 이동 농도
    private let fineDustValue24Response: String
    
    /// 미세먼지 24시간 등급
    private let fineDustGradeResponse: String
    
    /// 미세먼지 1시간 등급
    private let fineDustGrade1hResponse: String
    
    /// 초미세먼지 농도
    private let ultraFineDustValueResponse: String
    
    /// 초미세먼지 24시간 예측 이동 농도
    private let ultraFineDustValue24Response: String
    
    /// 초미세먼지 24시간 등급
    private let ultraFineDustGradeResponse: String
    
    /// 초미세먼지 1시간 등급
    private let ultraFineDustGrade1hResponse: String
    
    enum CodingKeys: String, CodingKey {
      
      case dataTime
      
      case fineDustValueResponse = "pm10Value"
      
      case fineDustValue24Response = "pm10Value24"
      
      case fineDustGradeResponse = "pm10Grade"
      
      case fineDustGrade1hResponse = "pm10Grade1h"
      
      case ultraFineDustValueResponse = "pm25Value"
      
      case ultraFineDustValue24Response = "pm25Value24"
      
      case ultraFineDustGradeResponse = "pm25Grade"
      
      case ultraFineDustGrade1hResponse = "pm25Grade1h"
    }
    
    /// 미세먼지 농도
    var fineDustValue: Int {
      return Int(fineDustValueResponse) ?? 0
    }
    
    /// 미세먼지 24시간 예측 이동 농도
    var fineDustValue24: Int {
      return Int(fineDustValue24Response) ?? 0
    }
    
    /// 미세먼지 24시간 등급
    var fineDustGrade: Int {
      return Int(fineDustGradeResponse) ?? 0
    }
    
    /// 미세먼지 1시간 등급
    var fineDustGrade1h: Int {
      return Int(fineDustGrade1hResponse) ?? 0
    }
    
    /// 초미세먼지 농도
    var ultraFineDustValue: Int {
      return Int(ultraFineDustValueResponse) ?? 0
    }
    
    /// 초미세먼지 24시간 예측 이동 농도
    var ultraFineDustValue24: Int {
      return Int(ultraFineDustValue24Response) ?? 0
    }
    
    /// 초미세먼지 24시간 등급
    var ultraFineDustGrade: Int {
      return Int(ultraFineDustGradeResponse) ?? 0
    }
    
    /// 초미세먼지 1시간 등급
    var ultraFineDustGrade1h: Int {
      return Int(ultraFineDustGrade1hResponse) ?? 0
    }
  }
  
  let list: [List]
  
  /// 응답 개수
  let totalCount: Int
  
  /// 서브스크립트로 리스트의 값에 접근. `response[1]`
  subscript(index: Int) -> List {
    return list[index]
  }
}
