//
//  IntakeManagerType.swift
//  FineDust
//
//  Created by Presto on 30/01/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import RxSwift

protocol IntakeServiceType {
  
  /// 오늘의 미세먼지 및 초미세먼지 섭취량 요청.
  func requestTodayIntake(completion: @escaping (Int?, Int?, Error?) -> Void)
  
  /// 지정 `Date`로부터 일주일 간의 미세먼지 섭취량 요청.
  func requestIntakesInWeek(completion: @escaping ([Int]?, [Int]?, Error?) -> Void)
  
  func requestTodayIntake() -> Observable<DustIntake>
  
  func requestIntakesInWeek() -> Observable<[DustIntake]>
}
