//
//  IntakesGenerator.swift
//  FineDust
//
//  Created by Presto on 28/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

// 1. IntakeGeneratorType 만들어서 함수 정의
protocol IntakeManagerType {
  
  /// 평균 보폭
  var averageStride: Double { get }
  
  /// 최근 7일의 흡입량 계산하여 컴플리션 핸들러에 넘겨줌
  func calculateIntakesInWeek(since date: Date, completion: @escaping ([Double]) -> Void)
}

// 2. IntakeGenerator가 1의 프로토콜을 준수하고 빌드가 가능하게만 구현해둠
class IntakeManager: IntakeManagerType {
  
  var healthKitManager: HealthKitManagerType
  
  var api: APIFineDustType
  
  // 평균 보폭 = ((키 * 0.37) + (키 - 100)) / 2 cm
  var averageStride: Double {
    return 60
  }
  
  init(healthKitManager: HealthKitManagerType = HealthKitManager(),
       apiService: APIFineDustType = API.shared) {
    self.healthKitManager = healthKitManager
    self.api = apiService
  }
  
  func calculateIntakesInWeek(since date: Date, completion: @escaping ([Double]) -> Void) {
    // 헬스킷매니저에서 걸음수 및 걸음거리 받아옴
    // API에서 미세먼지 농도 받아옴
    // 둘 사이에 어떠한 알고리즘 적용하여 값 넘겨줌
    completion([50, 6, 70, 285, 38, 6])
  }
}
