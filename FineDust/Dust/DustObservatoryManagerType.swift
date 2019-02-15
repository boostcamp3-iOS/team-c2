//
//  DustObservatoryManagerType.swift
//  FineDust
//
//  Created by Presto on 03/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

/// 관측소 관련 Dust Manager 프로토콜.
protocol DustObservatoryManagerType: DustManagerType {
  func requestObservatory(numberOfRows numOfRows: Int,
                          pageNumber pageNo: Int,
                          completion: @escaping (ObservatoryResponse?, Error?) -> Void)
}
