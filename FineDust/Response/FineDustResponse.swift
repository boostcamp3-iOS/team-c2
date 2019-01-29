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
    let fineDustValue: Int
    
    /// 미세먼지 24시간 예측 이동 농도
    let fineDustValue24: Int
    
    /// 미세먼지 24시간 등급
    let fineDustGrade: Int
    
    /// 미세먼지 1시간 등급
    let fineDustGrade1h: Int
    
    /// 초미세먼지 농도
    let ultraFineDustValue: Int
    
    /// 초미세먼지 24시간 예측 이동 농도
    let ultraFineDustValue24: Int
    
    /// 초미세먼지 24시간 등급
    let ultraFineDustGrade: Int
    
    /// 초미세먼지 1시간 등급
    let ultraFineDustGrade1h: Int
    
    enum CodingKeys: String, CodingKey {
      
      case dataTime
      
      case fineDustValue = "pm10Value"
      
      case fineDustValue24 = "pm10Value24"
      
      case fineDustGrade = "pm10Grade"
      
      case fineDustGrade1h = "pm10Grade1h"
      
      case ultraFineDustValue = "pm25Value"
      
      case ultraFineDustValue24 = "pm25Value24"
      
      case ultraFineDustGrade = "pm25Grade"
      
      case ultraFineDustGrade1h = "pm25Grade1h"
    }
    
    init(dataTime: String,
         fineDustValue: Int,
         fineDustValue24: Int,
         fineDustGrade: Int,
         fineDustGrade1h: Int,
         ultraFineDustValue: Int,
         ultraFineDustValue24: Int,
         ultraFineDustGrade: Int,
         ultraFineDustGrade1h: Int) {
      self.dataTime = dataTime
      self.fineDustValue = fineDustValue
      self.fineDustValue24 = fineDustValue24
      self.fineDustGrade = fineDustGrade
      self.fineDustGrade1h = fineDustGrade1h
      self.ultraFineDustValue = ultraFineDustValue
      self.ultraFineDustValue24 = ultraFineDustValue24
      self.ultraFineDustGrade = ultraFineDustGrade
      self.ultraFineDustGrade1h = ultraFineDustGrade1h
    }
    
    init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)
      dataTime = try values.decode(String.self, forKey: .dataTime)
      fineDustValue = Int(try values.decode(String.self, forKey: .fineDustValue)) ?? 0
      fineDustValue24 = Int(try values.decode(String.self, forKey: .fineDustValue24)) ?? 0
      fineDustGrade = Int(try values.decode(String.self, forKey: .fineDustGrade)) ?? 0
      fineDustGrade1h = Int(try values.decode(String.self, forKey: .fineDustGrade1h)) ?? 0
      ultraFineDustValue = Int(try values.decode(String.self, forKey: .ultraFineDustValue)) ?? 0
      ultraFineDustValue24
        = Int(try values.decode(String.self, forKey: .ultraFineDustValue24)) ?? 0
      ultraFineDustGrade = Int(try values.decode(String.self, forKey: .ultraFineDustGrade)) ?? 0
      ultraFineDustGrade1h
        = Int(try values.decode(String.self, forKey: .ultraFineDustGrade1h)) ?? 0
    }
  }
  
  /// 결과 리스트
  let list: [List]
  
  /// 응답 개수
  let totalCount: Int
  
  /// 서브스크립트로 리스트의 값에 접근. `response[1]`
  subscript(index: Int) -> List {
    return list[index]
  }
}
