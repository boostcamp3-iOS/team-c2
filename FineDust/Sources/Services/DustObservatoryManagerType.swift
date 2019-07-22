//
//  DustObservatoryManagerType.swift
//  FineDust
//
//  Created by Presto on 03/02/2019.
//  Copyright © 2019 boostcamp3rd. All rights reserved.
//

import Foundation

import RxSwift

protocol DustObservatoryManagerType: DustManagerType {
  
  /// 관측소 정보 요청.
  ///
  /// numberOfRows는 1, pageNumber는 1.
  func requestObservatory(numberOfRows numOfRows: Int,
                          pageNumber pageNo: Int,
                          completion: @escaping (ObservatoryResponse?, Error?) -> Void)
  
  func requestObservatory() -> Observable<ObservatoryResponse>
}
