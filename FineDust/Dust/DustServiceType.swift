//
//  DustServiceType.swift
//  FineDust
//
//  Created by Presto on 01/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// 미세먼지 Service Type.
protocol DustServiceType: class {
  
  /// 현재 미세먼지 관련 정보 fetch.
  func fetchCurrentResponse(_ completion: @escaping (CurrentDustInfo?, Error?) -> Void)
  
  /// 하루의 미세먼지 관련 정보를 fetch하고 시간대별 미세먼지 값과 초미세먼지 값을 산출.
  func fetchTodayDust(_ completion: @escaping ([Hour: Int]?, [Hour: Int]?, Error?) -> Void)
}
