//
//  IntakeManagerType.swift
//  FineDust
//
//  Created by Presto on 30/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

// 1. IntakeGeneratorType 만들어서 함수 정의
protocol IntakeManagerType {
  
  /// 평균 보폭
  var averageStride: Double { get }
  
  /// 최근 7일의 흡입량 계산하여 컴플리션 핸들러에 넘겨줌
  func calculateIntakesInWeek(since date: Date, completion: @escaping (Double) -> Void)
}
