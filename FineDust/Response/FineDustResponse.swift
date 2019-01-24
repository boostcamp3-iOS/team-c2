//
//  FineDustResponse.swift
//  FineDust
//
//  Created by Presto on 23/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

struct FineDustResponse: Codable {
  
  struct List: Codable {
    
    let dataTime: String
    
    /// 미세먼지 농도
    let fineDustValue: Int
    
    /// 미세먼지 24시간 예측 이동 농도
    let fineDustValue24: Int
    
    /// 미세먼지 24시간 등급
    let fineDustGrade: Int
    
    /// 미세먼지 1시간 등급
    let fineDustGrade1h: Int
    
    /// 초미세먼지 농도
    let ultrafineDustValue: Int
    
    /// 초미세먼지 24시간 예측 이동 농도
    let ultrafineDustValue24: Int
    
    /// 초미세먼지 24시간 등급
    let ultrafineDustGrade: Int
    
    /// 초미세먼지 1시간 등급
    let ultrafineDustGrade1h: Int
    
    enum CodingKeys: String, CodingKey {
      
      case dataTime
      
      case fineDustValue = "pm10Value"
      
      case fineDustValue24 = "pm10Value24"
      
      case fineDustGrade = "pm10Grade"
      
      case fineDustGrade1h = "pm10Grade1h"
      
      case ultrafineDustValue = "pm25Value"
      
      case ultrafineDustValue24 = "pm25Value24"
      
      case ultrafineDustGrade = "pm25Grade"
      
      case ultrafineDustGrade1h = "pm25Grade1h"
    }
  }
  
  let list: [List]
  
  /// 응답 개수
  let totalCount: Int
}
