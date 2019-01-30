//
//  IntakesGenerator.swift
//  FineDust
//
//  Created by Presto on 28/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

// 2. IntakeGenerator가 1의 프로토콜을 준수하고 빌드가 가능하게만 구현해둠
class IntakeManager: IntakeManagerType {
  
  var healthKitManager: HealthKitServiceManagerType
  
  var api: APIFineDustType
  
  // 평균 보폭 = ((키 * 0.37) + (키 - 100)) / 2 cm
  var averageStride: Double {
    return 60
  }
  
  init(healthKitManager: HealthKitServiceManagerType = HealthKitManager.shared,
       apiService: APIFineDustType = API.shared) {
    self.healthKitManager = healthKitManager
    self.api = apiService
  }
  
  func calculateIntakesInWeek(since date: Date, completion: @escaping (Double) -> Void) {
    // 헬스킷매니저에서 걸음수 및 걸음거리 받아옴
    // API에서 미세먼지 농도 받아옴
    // 둘 사이에 어떠한 알고리즘 적용하여 값 넘겨줌
    healthKitManager.fetchDistanceValue { [weak self] distance in
      self?.healthKitManager.fetchStepCountValue { steps in
        self?.api.fetchFineDustConcentration(term: .daily,
                                             pageNumber: 1,
                                             numberOfRows: 24) { response, error in
          let distance = distance
          let steps = steps
          let fineDustValue = Double(response?.items.first?.fineDustValue ?? 0)
          completion(distance * steps * fineDustValue)
        }
      }
    }
  }
}
